import 'dart:convert';
import 'package:lifecircle_mobile/src/features/timeline/domain/aggregates/timeline_aggregate.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/events/timeline_events.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/repositories/timeline_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

class TimelineLifecycleService {
  const TimelineLifecycleService({
    required this.timelineRepository,
    required this.outboxRepository,
  });

  final TimelineRepository timelineRepository;
  final OutboxRepository outboxRepository;

  Future<void> dispatch(
    ({TimelineAggregate aggregate, List<TimelineEvent> events}) result
  ) async {
    // 1. Persist local projection
    await timelineRepository.save(result.aggregate);

    // 2. Outbox the Domain Events
    for (final event in result.events) {
      final op = SyncOperation(
        operationId: event.eventId,
        entityId: event.timelineId,
        entityType: 'TimelineEvent',
        mutationType: MutationType.create,
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

  String _serializeEvent(TimelineEvent event) {
    if (event is TimelineCreated) {
      return jsonEncode({
        'eventType': 'TimelineCreated',
        'householdId': event.householdId,
      });
    }
    if (event is ActivityRecorded) {
      return jsonEncode({
        'eventType': 'ActivityRecorded',
        'entryId': event.entryId,
        'actorId': event.actorId,
        'activityType': event.activityType,
      });
    }
    if (event is ActivityDeleted) {
      return jsonEncode({
        'eventType': 'ActivityDeleted',
        'entryId': event.entryId,
        'deletedByActorId': event.deletedByActorId,
      });
    }
    if (event is TimelineArchived) {
      return jsonEncode({
        'eventType': 'TimelineArchived',
      });
    }
    return jsonEncode({'eventType': 'Unknown'});
  }
}
