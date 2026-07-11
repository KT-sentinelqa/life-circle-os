import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/actor.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/entities/activity.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/visibility.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/attachment_reference.dart';

@immutable
class TimelineEntry {
  const TimelineEntry({
    required this.entryId,
    required this.timelineId,
    required this.actor,
    required this.activity,
    required this.visibility,
    required this.timestamp,
    this.attachments = const [],
    this.isDeleted = false,
    this.editVersion = 1,
  });

  final String entryId;
  final String timelineId;
  final Actor actor;
  final Activity activity;
  final Visibility visibility;
  final DateTime timestamp;
  final List<AttachmentReference> attachments;
  final bool isDeleted;
  final int editVersion;

  TimelineEntry copyWith({
    Visibility? visibility,
    List<AttachmentReference>? attachments,
    bool? isDeleted,
    int? editVersion,
  }) {
    return TimelineEntry(
      entryId: entryId,
      timelineId: timelineId,
      actor: actor,
      activity: activity,
      visibility: visibility ?? this.visibility,
      timestamp: timestamp,
      attachments: attachments ?? this.attachments,
      isDeleted: isDeleted ?? this.isDeleted,
      editVersion: editVersion ?? this.editVersion,
    );
  }
}
