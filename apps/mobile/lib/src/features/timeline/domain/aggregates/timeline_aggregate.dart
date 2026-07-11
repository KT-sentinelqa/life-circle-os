import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/timeline_entry.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/events/timeline_events.dart';

@immutable
class TimelineAggregate {
  const TimelineAggregate._({
    required this.timelineId,
    required this.householdId,
    required this.entries,
    required this.isArchived,
    this.lastActivityAt,
  });

  final String timelineId;
  final String householdId;
  final Map<String, TimelineEntry> entries;
  final bool isArchived;
  final DateTime? lastActivityAt;

  // --- Aggregate Behaviors ---

  static ({TimelineAggregate aggregate, List<TimelineEvent> events}) create({
    required String householdId,
  }) {
    final timelineId = const Uuid().v4();

    final aggregate = TimelineAggregate._(
      timelineId: timelineId,
      householdId: householdId,
      entries: const {},
      isArchived: false,
    );

    final event = TimelineCreated(
      timelineId: timelineId,
      householdId: householdId,
    );

    return (aggregate: aggregate, events: [event]);
  }

  ({TimelineAggregate aggregate, List<TimelineEvent> events}) recordActivity(TimelineEntry entry) {
    if (isArchived) {
      throw Exception('Cannot record activity on an archived timeline.');
    }
    if (entries.containsKey(entry.entryId)) {
      throw Exception('Duplicate activity: Entry already exists in timeline.');
    }
    if (lastActivityAt != null && entry.timestamp.isBefore(lastActivityAt!)) {
      throw Exception('Monotonic timestamp violation: Activity cannot be recorded in the past.');
    }
    if (entry.actor.isSystem == false && entry.actor.memberId.isEmpty) {
      throw Exception('Actor violation: Invalid or deleted member cannot create activity.');
    }

    final newEntries = Map<String, TimelineEntry>.from(entries);
    newEntries[entry.entryId] = entry;

    final event = ActivityRecorded(
      timelineId: timelineId,
      entryId: entry.entryId,
      actorId: entry.actor.memberId,
      activityType: entry.activity.type.name,
    );

    return (
      aggregate: copyWith(entries: newEntries, lastActivityAt: entry.timestamp),
      events: [event],
    );
  }

  ({TimelineAggregate aggregate, List<TimelineEvent> events}) deleteActivity(String entryId, String deletedByActorId) {
    if (isArchived) {
      throw Exception('Cannot modify an archived timeline.');
    }
    if (!entries.containsKey(entryId)) {
      throw Exception('Activity not found.');
    }
    if (entries[entryId]!.isDeleted) {
      throw Exception('Activity is already deleted.');
    }

    final updatedEntry = entries[entryId]!.copyWith(isDeleted: true, editVersion: entries[entryId]!.editVersion + 1);
    final newEntries = Map<String, TimelineEntry>.from(entries);
    newEntries[entryId] = updatedEntry;

    final event = ActivityDeleted(
      timelineId: timelineId,
      entryId: entryId,
      deletedByActorId: deletedByActorId,
    );

    return (
      aggregate: copyWith(entries: newEntries),
      events: [event],
    );
  }

  ({TimelineAggregate aggregate, List<TimelineEvent> events}) archiveTimeline() {
    if (isArchived) {
      throw Exception('Timeline is already archived.');
    }

    final event = TimelineArchived(timelineId: timelineId);

    return (
      aggregate: copyWith(isArchived: true),
      events: [event],
    );
  }

  // --- Helpers ---

  TimelineAggregate copyWith({
    Map<String, TimelineEntry>? entries,
    bool? isArchived,
    DateTime? lastActivityAt,
  }) {
    return TimelineAggregate._(
      timelineId: timelineId,
      householdId: householdId,
      entries: entries ?? this.entries,
      isArchived: isArchived ?? this.isArchived,
      lastActivityAt: lastActivityAt ?? this.lastActivityAt,
    );
  }
}
