import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/aggregates/timeline_aggregate.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/timeline_entry.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/actor.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/activity.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/visibility.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/activity_type.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/events/timeline_events.dart';

void main() {
  group('Phase 3A Sprint 3: Timeline Aggregate', () {
    late Actor dummyActor;
    late Activity dummyActivity;
    late Visibility dummyVisibility;

    setUp(() {
      dummyActor = const Actor(memberId: 'mem_1', name: 'Krishna');
      dummyActivity = const Activity(
        type: ActivityType('medicine_taken'),
        payload: '{"medId": "med_1"}',
      );
      dummyVisibility = const Visibility(VisibilityLevel.public);
    });

    test('Creating timeline yields TimelineCreated event', () {
      final result = TimelineAggregate.create(householdId: 'hh_1');

      expect(result.aggregate.householdId, 'hh_1');
      expect(result.aggregate.entries, isEmpty);
      expect(result.events.length, 1);
      expect(result.events.first, isA<TimelineCreated>());
    });

    test('Recording valid activity yields ActivityRecorded event', () {
      final init = TimelineAggregate.create(householdId: 'hh_1');
      final timeline = init.aggregate;

      final entry = TimelineEntry(
        entryId: 'entry_1',
        timelineId: timeline.timelineId,
        actor: dummyActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: DateTime.now(),
      );

      final result = timeline.recordActivity(entry);

      expect(result.aggregate.entries.length, 1);
      expect(result.events.length, 1);
      expect(result.events.first, isA<ActivityRecorded>());
    });

    test('Recording duplicate entry ID throws Exception', () {
      final init = TimelineAggregate.create(householdId: 'hh_1');
      
      final entry = TimelineEntry(
        entryId: 'entry_1',
        timelineId: init.aggregate.timelineId,
        actor: dummyActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: DateTime.now(),
      );

      final result = init.aggregate.recordActivity(entry);

      // Attempt to record the exact same entry ID again
      expect(
        () => result.aggregate.recordActivity(entry),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Duplicate activity'))),
      );
    });

    test('Monotonic timestamp violation throws Exception', () {
      final init = TimelineAggregate.create(householdId: 'hh_1');
      
      final entry1 = TimelineEntry(
        entryId: 'entry_1',
        timelineId: init.aggregate.timelineId,
        actor: dummyActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: DateTime.now(),
      );

      final result = init.aggregate.recordActivity(entry1);

      // Attempt to record an entry with a timestamp in the past
      final entry2 = TimelineEntry(
        entryId: 'entry_2',
        timelineId: init.aggregate.timelineId,
        actor: dummyActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: entry1.timestamp.subtract(const Duration(hours: 1)),
      );

      expect(
        () => result.aggregate.recordActivity(entry2),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Monotonic timestamp violation'))),
      );
    });

    test('Deleted Member cannot record activity', () {
      final init = TimelineAggregate.create(householdId: 'hh_1');
      
      final deletedActor = const Actor(memberId: '', name: 'Deleted User'); // Empty memberId
      
      final entry = TimelineEntry(
        entryId: 'entry_1',
        timelineId: init.aggregate.timelineId,
        actor: deletedActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: DateTime.now(),
      );

      expect(
        () => init.aggregate.recordActivity(entry),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('Actor violation'))),
      );
    });

    test('Soft delete yields ActivityDeleted event and bumps editVersion', () {
      final init = TimelineAggregate.create(householdId: 'hh_1');
      
      final entry = TimelineEntry(
        entryId: 'entry_1',
        timelineId: init.aggregate.timelineId,
        actor: dummyActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: DateTime.now(),
      );

      final recorded = init.aggregate.recordActivity(entry);

      final deleted = recorded.aggregate.deleteActivity('entry_1', 'mem_1');

      expect(deleted.aggregate.entries['entry_1']!.isDeleted, isTrue);
      expect(deleted.aggregate.entries['entry_1']!.editVersion, 2);
      expect(deleted.events.length, 1);
      expect(deleted.events.first, isA<ActivityDeleted>());
    });

    test('Archived timeline rejects mutations', () {
      final init = TimelineAggregate.create(householdId: 'hh_1');
      
      final archived = init.aggregate.archiveTimeline();

      final entry = TimelineEntry(
        entryId: 'entry_1',
        timelineId: archived.aggregate.timelineId,
        actor: dummyActor,
        activity: dummyActivity,
        visibility: dummyVisibility,
        timestamp: DateTime.now(),
      );

      expect(
        () => archived.aggregate.recordActivity(entry),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('archived'))),
      );
    });
  });
}
