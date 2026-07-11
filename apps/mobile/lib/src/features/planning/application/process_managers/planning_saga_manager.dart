import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/documents/domain/events/document_events.dart';
import 'package:lifecircle_mobile/src/features/vehicles/domain/events/vehicle_events.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/aggregates/task_aggregate.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/priority.dart';

/// The PlanningSagaManager orchestrates cross-domain workflows.
/// It listens to the EventBus for specific domain events (e.g. DocumentExpired)
/// and issues commands to the TaskAggregate to create tasks automatically.
class PlanningSagaManager {
  PlanningSagaManager(this.eventBus, this.taskAggregate);

  final DomainEventBus eventBus;
  // In a real implementation, this would be a repository fetch based on the event's householdId.
  final TaskAggregate taskAggregate; 

  void startListening() {
    eventBus.stream.listen(_handleEvent);
  }

  void _handleEvent(DomainEvent event) {
    try {
      if (event is DocumentExpired) {
        _handleDocumentExpired(event);
      } else if (event is ServiceRecorded) {
        _handleVehicleServiceRecorded(event);
      }
    } catch (e) {
      // Sagas must not crash the event bus.
      // Log the saga failure without rolling back the original aggregate transaction.
      print('Saga Error: $e');
    }
  }

  void _handleDocumentExpired(DocumentExpired event) {
    // Generate an automatic high-priority task when a document expires.
    final result = taskAggregate.createTask(
      ownerId: 'system',
      ownerName: 'LifeCircle System',
      title: 'Renew Document: ${event.documentName}',
      description: 'The document ${event.documentName} has expired. Please upload a renewal.',
      priority: Priority.high,
    );

    // In a production environment, the saga would save the aggregate via a repository
    // and then publish the new PlanningEvents back to the EventBus.
    for (final newEvent in result.events) {
      eventBus.publish(newEvent);
    }
  }

  void _handleVehicleServiceRecorded(ServiceRecorded event) {
    // Generate a low-priority task for 6-month checkup.
    final result = taskAggregate.createTask(
      ownerId: 'system',
      ownerName: 'LifeCircle System',
      title: 'Schedule next service for ${event.makeModel}',
      description: 'Your last service was at ${event.odometerReading}km. Next checkup due in 6 months.',
      priority: Priority.low,
    );

    for (final newEvent in result.events) {
      eventBus.publish(newEvent);
    }
  }
}
