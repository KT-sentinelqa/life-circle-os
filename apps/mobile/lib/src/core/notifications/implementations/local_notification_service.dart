import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/notification_payload.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/scheduled_notification.dart';
import 'package:timezone/timezone.dart' as tz;

/// Local implementation of [NotificationService].
class LocalNotificationService implements NotificationService {
  /// Creates a [LocalNotificationService].
  LocalNotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<void> schedule(ScheduledNotification notification) async {
    const androidDetails = AndroidNotificationDetails(
      'medicine_reminders',
      'Medicine Reminders',
      channelDescription: 'Notifications for your scheduled medicines.',
      importance: Importance.max,
      priority: Priority.high,
    );
    const darwinDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: darwinDetails,
      macOS: darwinDetails,
    );

    final scheduledDate =
        tz.TZDateTime.from(notification.scheduledAt, tz.local);

    await _plugin.zonedSchedule(
      notification.id,
      notification.title,
      notification.body,
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: notification.payload.toJsonString(),
    );
  }

  @override
  Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  @override
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  @override
  Future<List<ScheduledNotification>> getScheduledNotifications() async {
    final pending = await _plugin.pendingNotificationRequests();
    
    final scheduled = <ScheduledNotification>[];
    for (final request in pending) {
      if (request.payload != null) {
        try {
          final payload = NotificationPayload.fromJsonString(request.payload!);
          scheduled.add(
            ScheduledNotification(
              id: request.id,
              title: request.title ?? '',
              body: request.body ?? '',
              scheduledAt: DateTime.now().toUtc(), 
              payload: payload,
            ),
          );
        } catch (_) {
          // Ignore parse errors from unknown payloads
        }
      }
    }
    
    return scheduled;
  }
}
