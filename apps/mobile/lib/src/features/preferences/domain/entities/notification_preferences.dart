import 'package:flutter/foundation.dart';

@immutable
class NotificationPreferences {
  const NotificationPreferences({
    required this.globalPushEnabled,
    required this.quietHoursEnabled,
  });

  final bool globalPushEnabled;
  final bool quietHoursEnabled;

  NotificationPreferences copyWith({
    bool? globalPushEnabled,
    bool? quietHoursEnabled,
  }) {
    return NotificationPreferences(
      globalPushEnabled: globalPushEnabled ?? this.globalPushEnabled,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
    );
  }
}
