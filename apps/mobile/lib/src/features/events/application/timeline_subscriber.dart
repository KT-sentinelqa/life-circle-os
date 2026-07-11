import 'dart:async';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/timeline/application/activity_recording_service.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/timeline_entry.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/actor.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/activity.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/visibility.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/activity_type.dart';

abstract class TimelineRoutableEvent implements DomainEvent {
  String get householdId;
  String get actorId;
  String get actorName;
  String get activityTypeName;
}

class TimelineSubscriber {
  TimelineSubscriber({
    required this.eventBus,
    required this.recordingService,
  }) {
    _subscription = eventBus.on<TimelineRoutableEvent>().listen(_handleEvent);
  }

  final DomainEventBus eventBus;
  final ActivityRecordingService recordingService;
  late final StreamSubscription _subscription;

  Future<void> _handleEvent(TimelineRoutableEvent event) async {
    final entry = TimelineEntry(
      entryId: const Uuid().v4(),
      timelineId: '', // Will be resolved by the recording service
      actor: Actor(memberId: event.actorId, name: event.actorName),
      activity: Activity(
        type: ActivityType(event.activityTypeName),
        payload: jsonEncode(event.toJson()),
      ),
      visibility: const Visibility(VisibilityLevel.public),
      timestamp: event.timestamp,
    );

    await recordingService.recordCrossDomainActivity(
      householdId: event.householdId,
      entry: entry,
    );
  }

  void dispose() {
    _subscription.cancel();
  }
}
