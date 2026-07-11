import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/events/document_events.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/aggregates/task_aggregate.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/events/planning_events.dart';
import 'package:lifecircle_mobile/src/features/planning/application/process_managers/planning_saga_manager.dart';

void main() {
  group('Phase 3B Sprint 6: Planning Saga Manager', () {
    test('Saga listens to DocumentExpired and creates a high priority task', () async {
      final eventBus = DomainEventBus();
      final aggregate = TaskAggregate.initialize('hh_1').aggregate;
      
      final saga = PlanningSagaManager(eventBus, aggregate);
      saga.startListening();

      // We need to capture what the saga pushes back to the bus
      final completer = Completer<DomainEvent>();
      eventBus.stream.listen((event) {
        if (event is TaskCreated) {
          completer.complete(event);
        }
      });

      // Emit a cross-domain event
      final foreignEvent = DocumentExpired(
        documentId: 'doc_123',
        householdId: 'hh_1',
        documentName: 'Passport',
      );
      
      eventBus.publish(foreignEvent);

      final resultEvent = await completer.future;

      expect(resultEvent, isA<TaskCreated>());
      final taskEvent = resultEvent as TaskCreated;
      expect(taskEvent.taskTitle, 'Renew Document: Passport');
    });
  });
}
