import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
abstract class TimelineEvent {
  TimelineEvent({
    required this.timelineId,
  })  : eventId = const Uuid().v4(),
        timestamp = DateTime.now().toUtc();

  final String eventId;
  final String timelineId;
  final DateTime timestamp;
}

class TimelineCreated extends TimelineEvent {
  TimelineCreated({
    required super.timelineId,
    required this.householdId,
  });

  final String householdId;
}

class ActivityRecorded extends TimelineEvent {
  ActivityRecorded({
    required super.timelineId,
    required this.entryId,
    required this.actorId,
    required this.activityType,
  });

  final String entryId;
  final String actorId;
  final String activityType;
}

class ActivityDeleted extends TimelineEvent {
  ActivityDeleted({
    required super.timelineId,
    required this.entryId,
    required this.deletedByActorId,
  });

  final String entryId;
  final String deletedByActorId;
}

class VisibilityChanged extends TimelineEvent {
  VisibilityChanged({
    required super.timelineId,
    required this.entryId,
    required this.newVisibilityLevel,
  });

  final String entryId;
  final String newVisibilityLevel;
}

class TimelineArchived extends TimelineEvent {
  TimelineArchived({required super.timelineId});
}
