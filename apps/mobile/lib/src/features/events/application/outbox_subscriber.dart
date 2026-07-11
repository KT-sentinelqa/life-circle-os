import 'dart:async';
import 'dart:convert';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/repositories/outbox_repository.dart';
import 'package:lifecircle_mobile/src/features/sync/domain/entities/sync_operation.dart';

class OutboxSubscriber {
  OutboxSubscriber({
    required this.eventBus,
    required this.outboxRepository,
  }) {
    _subscription = eventBus.on<DomainEvent>().listen(_handleEvent);
  }

  final DomainEventBus eventBus;
  final OutboxRepository outboxRepository;
  late final StreamSubscription _subscription;

  Future<void> _handleEvent(DomainEvent event) async {
    final op = SyncOperation(
      operationId: event.eventId,
      entityId: event.aggregateId,
      entityType: event.runtimeType.toString(),
      mutationType: MutationType.update, // Default mapping
      payload: jsonEncode(event.toJson()),
      timestamp: event.timestamp,
      sequenceNumber: DateTime.now().millisecondsSinceEpoch,
      idempotencyKey: event.eventId,
      status: SyncOperationStatus.pending,
      retryCount: 0,
      attempt: 0,
    );

    await outboxRepository.enqueue(op);
  }

  void dispose() {
    _subscription.cancel();
  }
}
