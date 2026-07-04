import 'package:lifecircle_mobile/src/core/notifications/models/notification_payload.dart';

/// Represents a notification scheduling request or a currently
/// scheduled notification.
class ScheduledNotification {
  /// Creates a [ScheduledNotification].
  const ScheduledNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledAt,
    required this.payload,
  });

  /// Deterministic integer ID used by the OS.
  final int id;

  /// Notification title.
  final String title;

  /// Notification body text.
  final String body;

  /// The exact local time the notification is scheduled to appear.
  final DateTime scheduledAt;

  /// The business payload attached to this notification.
  final NotificationPayload payload;
}
