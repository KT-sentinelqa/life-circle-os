/// Represents a notification scheduling request.
class NotificationRequest {
  /// Creates a [NotificationRequest].
  const NotificationRequest({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledAt,
  });

  /// Unique identifier.
  final String id;
  /// Notification title.
  final String title;
  /// Notification body.
  final String body;
  /// Time to schedule the notification.
  final DateTime scheduledAt;
}

/// Abstract interface for notification services.
abstract interface class NotificationService {
  /// Schedules a notification.
  Future<void> schedule(NotificationRequest request);
  /// Cancels a notification by ID.
  Future<void> cancel(String id);
  /// Cancels all notifications.
  Future<void> cancelAll();
}
