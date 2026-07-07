import 'dart:convert';
import 'package:isar/isar.dart';
import '../domain/models/sync_event.dart';
import '../infrastructure/cloud_sync_client.dart';
import '../../device_auth/application/device_crypto_service.dart';
import '../../responsibilities/domain/models/family_responsibility.dart';

class SyncService {
  final Isar _isar;
  final CloudSyncClient _cloudClient;
  final DeviceCryptoService _cryptoService;

  SyncService(this._isar, this._cloudClient, this._cryptoService);

  /// Phase 1: Upload (Outbox Pattern)
  /// Reads pending Outbox events, signs them, and attempts upload.
  Future<void> flushOutbox() async {
    final pendingEvents = await _isar.syncEvents
        .filter()
        .stateEqualTo(SyncEventState.pendingUpload)
        .findAll();

    for (var event in pendingEvents) {
      // 1. Sign Payload (ADR-028 / SEC-023)
      event.signature = await _cryptoService.signPayload(
        event.eventId, 
        event.logicalTimestamp, 
        event.payloadJson
      );

      // 2. Upload to Cloud
      final ack = await _cloudClient.pushEvent(event);

      // 3. Delete from Outbox on ACK (Dumb Pipeline)
      if (ack) {
        await _isar.writeTxn(() async {
          event.state = SyncEventState.processed;
          await _isar.syncEvents.put(event);
          // In a real app, we might delete it entirely here to save space
        });
      }
    }
  }

  /// Phase 2 & 3: Download and Conflict Resolution (Inbox Pattern)
  Future<void> processInbox(List<SyncEvent> incomingEvents) async {
    await _isar.writeTxn(() async {
      for (var event in incomingEvents) {
        // Find existing aggregate (the task)
        final existingTask = await _isar.familyResponsibilitys
            .filter()
            .uuidEqualTo(event.aggregateId)
            .findFirst();

        if (existingTask == null) {
          // If it doesn't exist locally, it's a new task. Apply it.
          // (Deserialization omitted for brevity in design phase)
        } else {
          // ADR-027 Conflict Resolution: Last-Write-Wins based on logical_timestamp
          final localTimestamp = existingTask.updatedAt.millisecondsSinceEpoch;
          
          if (event.logicalTimestamp > localTimestamp) {
            // Cloud event is newer. Overwrite local state.
            // (Deserialization and apply omitted for brevity)
          } else {
            // Local state is newer. Safely reject (ignore) the incoming event.
            // The Cloud is eventually consistent; our device is correct.
          }
        }
      }
    });
  }
}
