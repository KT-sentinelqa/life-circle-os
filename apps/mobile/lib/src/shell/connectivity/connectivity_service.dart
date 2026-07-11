import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity status for the LifeCircle platform.
enum LcConnectivityStatus { online, offline }

/// ConnectivityService — Global Service
///
/// Monitors real-time network state and broadcasts changes.
/// Consumed by the App Shell to drive the offline banner and
/// the sync status indicator (UX Constitution Law 9).
///
/// The service is intentionally simple: it exposes a [ValueNotifier]
/// so any widget can listen with [ValueListenableBuilder] without
/// requiring a state management library dependency at the shell level.
class ConnectivityService {
  ConnectivityService() {
    _init();
  }

  final _statusNotifier = ValueNotifier<LcConnectivityStatus>(
    LcConnectivityStatus.online,
  );

  ValueListenable<LcConnectivityStatus> get statusListenable => _statusNotifier;
  LcConnectivityStatus get status => _statusNotifier.value;
  bool get isOnline  => status == LcConnectivityStatus.online;
  bool get isOffline => !isOnline;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void _init() {
    // Check current status immediately
    Connectivity().checkConnectivity().then(_onResults);

    // Then listen for changes
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen(_onResults);
  }

  void _onResults(List<ConnectivityResult> results) {
    final isConnected = results.any(
      (r) => r != ConnectivityResult.none,
    );
    final newStatus = isConnected
        ? LcConnectivityStatus.online
        : LcConnectivityStatus.offline;

    if (_statusNotifier.value != newStatus) {
      _statusNotifier.value = newStatus;
    }
  }

  void dispose() {
    _subscription?.cancel();
    _statusNotifier.dispose();
  }
}
