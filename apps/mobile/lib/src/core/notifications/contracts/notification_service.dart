import 'package:lifecircle_mobile/src/core/notifications/models/scheduled_notification.dart';

/// Abstract interface for notification services.
abstract interface class NotificationService {
  /// Schedules a notification.
  /// If a notification with the same deterministic ID already exists,
  /// it is replaced.
  Future<void> schedule(ScheduledNotification notification);

  /// Cancels a notification by its deterministic ID.
  Future<void> cancel(int id);

  /// Cancels all scheduled notifications.
  Future<void> cancelAll();

  /// Retrieves all currently scheduled notifications from the OS.
  Future<List<ScheduledNotification>> getScheduledNotifications();
}
