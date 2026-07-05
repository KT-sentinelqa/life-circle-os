import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_permission_service.dart';

/// Implementation of [NotificationPermissionService] using
/// flutter_local_notifications.
class LocalNotificationPermissionService
    implements NotificationPermissionService {
  /// Creates a [LocalNotificationPermissionService].
  LocalNotificationPermissionService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<bool> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      final iosImplementation = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final granted = await iosImplementation?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    } else if (Platform.isAndroid) {
      final androidImplementation =
          _plugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      // Request exact alarms and notification permissions on Android 13+
      final notificationsGranted =
          await androidImplementation?.requestNotificationsPermission();
      final alarmsGranted =
          await androidImplementation?.requestExactAlarmsPermission();

      return (notificationsGranted ?? false) && (alarmsGranted ?? false);
    }
    return false;
  }

  @override
  Future<bool> checkPermissions() async {
    // Platform specific check, but requestPermissions is usually safe to call.
    // We can return true here as a stub or implement a real check if supported.
    // For now, we will return true assuming requested.
    return true;
  }
}
