import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/household/domain/aggregates/household_aggregate.dart';
import 'package:lifecircle_mobile/src/features/household/domain/events/household_events.dart';
import 'package:lifecircle_mobile/src/features/household/domain/repositories/household_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

class HouseholdLifecycleService {
  const HouseholdLifecycleService({
    required this.householdRepository,
    required this.outboxRepository,
  });

  final HouseholdRepository householdRepository;
  final OutboxRepository outboxRepository;

  Future<void> dispatch(
    ({HouseholdAggregate aggregate, List<HouseholdEvent> events}) result
  ) async {
    // 1. Persist local state
    await householdRepository.save(result.aggregate);

    // 2. Map Events to Sync Operations (Event Sourcing over Outbox)
    for (final event in result.events) {
      final op = SyncOperation(
        operationId: event.eventId,
        entityId: event.householdId,
        entityType: 'HouseholdEvent',
        mutationType: MutationType.create, // We are appending immutable events
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

  String _serializeEvent(HouseholdEvent event) {
    if (event is HouseholdCreated) {
      return jsonEncode({
        'eventType': 'HouseholdCreated',
        'name': event.name,
        'ownerId': event.ownerId,
      });
    }
    if (event is HouseholdUpdated) {
      return jsonEncode({
        'eventType': 'HouseholdUpdated',
        'name': event.name,
        'primaryEmail': event.primaryEmail,
      });
    }
    if (event is HouseholdArchived) {
      return jsonEncode({
        'eventType': 'HouseholdArchived',
      });
    }
    if (event is TimezoneChanged) {
      return jsonEncode({
        'eventType': 'TimezoneChanged',
        'newTimezone': event.newTimezone,
      });
    }
    if (event is CurrencyMigrated) {
      return jsonEncode({
        'eventType': 'CurrencyMigrated',
        'newCurrency': event.newCurrency,
      });
    }
    // Fallback
    return jsonEncode({'eventType': 'Unknown'});
  }
}
