import 'package:flutter/foundation.dart';

@immutable
class TimelineEntryDTO {
  const TimelineEntryDTO({
    required this.entryId,
    required this.actorName,
    required this.activityType,
    required this.payloadJson,
    required this.timestampIso,
  });

  final String entryId;
  final String actorName;
  final String activityType;
  final String payloadJson;
  final String timestampIso;

  Map<String, dynamic> toJson() => {
    'entryId': entryId,
    'actorName': actorName,
    'activityType': activityType,
    'payloadJson': payloadJson,
    'timestampIso': timestampIso,
  };
}
