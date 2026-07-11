import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/connectivity_state.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/outbox_entry_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_status_entity.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/models/sync_event.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/sync_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/infrastructure/cloud_sync_client.dart';

/// Background service responsible for driving the synchronization process.
class SyncEngineService {
  /// Creates a [SyncEngineService] requiring a repository and connectivity.
  SyncEngineService(
    this._syncRepository,
    this._cloudClient,
    this._connectivity,
  ) {
    _initConnectivity();
    _startPeriodicSync();
  }

  final SyncRepository _syncRepository;
  final CloudSyncClient _cloudClient;
  final Connectivity _connectivity;

  ConnectivityState _currentState = ConnectivityState.unknown;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _syncTimer;
  bool _isSyncing = false;

  void _initConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityResults,
    );
  }

  void _handleConnectivityResults(List<ConnectivityResult> results) {
    final result = results.firstOrNull ?? ConnectivityResult.none;
    final newState = _mapConnectivity(result);

    if (newState != _currentState) {
      _currentState = newState;
      if (_currentState == ConnectivityState.online) {
        _triggerSync();
      }
    }
  }

  void _startPeriodicSync() {
    _syncTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (_currentState == ConnectivityState.online) {
        _triggerSync();
      }
    });
  }

  ConnectivityState _mapConnectivity(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
      case ConnectivityResult.satellite:
        return ConnectivityState.online;
      case ConnectivityResult.bluetooth:
        return ConnectivityState.limited;
      case ConnectivityResult.none:
      case ConnectivityResult.other:
        return ConnectivityState.offline;
    }
  }

  Future<void> _triggerSync() async {
    if (_isSyncing || _currentState != ConnectivityState.online) return;

    _isSyncing = true;
    try {
      final pendingJobs = await _syncRepository.getPendingEntries();
      final now = DateTime.now();

      for (final job in pendingJobs) {
        if (job.nextRetryAt != null && job.nextRetryAt!.isAfter(now)) {
          continue;
        }

        await _processJob(job);
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processJob(OutboxEntryEntity job) async {
    await _syncRepository.updateEntryStatus(
      job.id,
      SyncStatusEntity.inProgress,
    );

    try {
      final event = SyncEvent()
        ..eventId = job.id
        ..aggregateId = job.aggregateId
        ..eventType = job.operationType
        ..payloadJson = job.payload
        ..createdAt = job.createdAt
        ..schemaVersion = 1
        ..deviceId = 'system'
        ..userId = 'system'
        ..logicalTimestamp = 0
        ..signature = ''
        ..correlationId = job.id
        ..idempotencyKey = job.id
        ..state = SyncEventState.pendingUpload
        ..retryCount = 0;

      final success = await _cloudClient.pushEvent(event);

      if (!success) {
        throw Exception('Cloud sync client rejected event');
      }

      await _syncRepository.updateEntryStatus(
        job.id,
        SyncStatusEntity.completed,
      );
    } catch (e) {
      _handleFailure(job);
    }
  }

  void _handleFailure(OutboxEntryEntity job) {
    final newRetryCount = job.retryCount + 1;
    if (newRetryCount > 5) {
      _syncRepository.updateEntryStatus(
        job.id,
        SyncStatusEntity.deadLetter,
      );
      return;
    }

    final nextRetryAt = DateTime.now().add(_getBackoffDuration(newRetryCount));
    _syncRepository.updateEntryStatus(
      job.id,
      SyncStatusEntity.failed,
      retryCount: newRetryCount,
      nextRetryAt: nextRetryAt,
    );
  }

  Duration _getBackoffDuration(int retryAttempt) {
    switch (retryAttempt) {
      case 1:
        return Duration.zero;
      case 2:
        return const Duration(seconds: 5);
      case 3:
        return const Duration(seconds: 30);
      case 4:
        return const Duration(minutes: 2);
      case 5:
        return const Duration(minutes: 10);
      default:
        return const Duration(minutes: 10);
    }
  }

  /// Disposes of active timers and subscriptions.
  void dispose() {
    _connectivitySubscription?.cancel();
    _syncTimer?.cancel();
  }
}
