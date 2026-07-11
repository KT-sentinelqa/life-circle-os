import 'package:flutter/foundation.dart';
import 'package:lifecircle_mobile/src/features/timeline/domain/value_objects/activity_type.dart';

@immutable
class Activity {
  const Activity({
    required this.type,
    required this.payload, // A stringified JSON representation of the cross-domain event
  });

  final ActivityType type;
  final String payload; 
}
