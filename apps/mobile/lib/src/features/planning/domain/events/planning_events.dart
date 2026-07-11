import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';

abstract class PlanningEvent implements DomainEvent {
  PlanningEvent({
    required this.planningId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  @override
  final String eventId;
  final String planningId;
  @override
  final DateTime timestamp;

  @override
  String get aggregateId => planningId;
}

class TaskCreated extends PlanningEvent implements TimelineRoutableEvent {
  TaskCreated({
    required super.planningId,
    required this.householdId,
    required this.ownerId,
    required this.ownerName,
    required this.taskTitle,
  });

  @override
  final String householdId;
  final String ownerId;
  final String ownerName;
  final String taskTitle;

  @override
  String get actorId => ownerId;
  @override
  String get actorName => ownerName;
  @override
  String get activityTypeName => 'task_created';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'TaskCreated',
    'householdId': householdId,
    'ownerId': ownerId,
    'taskTitle': taskTitle,
  };
}

class TaskCompleted extends PlanningEvent implements TimelineRoutableEvent {
  TaskCompleted({
    required super.planningId,
    required this.householdId,
    required this.actorId,
    required this.actorName,
    required this.taskTitle,
  });

  @override
  final String householdId;
  final String actorId;
  final String actorName;
  final String taskTitle;

  @override
  String get actorId => actorId;
  @override
  String get actorName => actorName;
  @override
  String get activityTypeName => 'task_completed';

  @override
  Map<String, dynamic> toJson() => {
    'eventType': 'TaskCompleted',
    'householdId': householdId,
    'actorId': actorId,
    'taskTitle': taskTitle,
  };
}
