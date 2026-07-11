import 'dart:convert';
import 'package:lifecircle_mobile/src/features/preferences/domain/aggregates/shared_preference_aggregate.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/events/preference_events.dart';
import 'package:lifecircle_mobile/src/features/preferences/domain/repositories/preference_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

class PreferenceLifecycleService {
  const PreferenceLifecycleService({
    required this.preferenceRepository,
    required this.outboxRepository,
  });

  final PreferenceRepository preferenceRepository;
  final OutboxRepository outboxRepository;

  Future<void> dispatch(
    ({SharedPreferenceAggregate aggregate, List<PreferenceEvent> events}) result
  ) async {
    // 1. Persist local state
    await preferenceRepository.save(result.aggregate);

    // 2. Map Events to Sync Operations
    for (final event in result.events) {
      final op = SyncOperation(
        operationId: event.eventId,
        entityId: event.householdId,
        entityType: 'PreferenceEvent',
        mutationType: MutationType.update,
        payload: _serializeEvent(event),
        timestamp: event.timestamp,
        sequenceNumber: DateTime.now().millisecondsSinceEpoch,
        idempotencyKey: event.eventId,
        status: SyncOperationStatus.pending,
        retryCount: 0,
        attempt: 0,
      );

      await outboxRepository.enqueue(op);
    }
  }

  String _serializeEvent(PreferenceEvent event) {
    if (event is PrivacyPolicyUpdated) {
      return jsonEncode({
        'eventType': 'PrivacyPolicyUpdated',
        'dataSharingConsent': event.dataSharingConsent,
        'telemetryEnabled': event.telemetryEnabled,
      });
    }
    if (event is AIAssistantToggled) {
      return jsonEncode({
        'eventType': 'AIAssistantToggled',
        'assistantEnabled': event.assistantEnabled,
      });
    }
    if (event is AutomationsSuspended) {
      return jsonEncode({
        'eventType': 'AutomationsSuspended',
      });
    }
    return jsonEncode({'eventType': 'Unknown'});
  }
}
