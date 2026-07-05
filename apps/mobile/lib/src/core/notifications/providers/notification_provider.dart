import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_permission_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/implementations/local_notification_permission_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/implementations/local_notification_service.dart';

/// Provider for the Flutter Local Notifications plugin.
final flutterLocalNotificationsPluginProvider =
    Provider<FlutterLocalNotificationsPlugin>((ref) {
  return FlutterLocalNotificationsPlugin();
});

/// Provider for the Notification Service.
final notificationServiceProvider = Provider<NotificationService>((ref) {
  final plugin = ref.watch(flutterLocalNotificationsPluginProvider);
  return LocalNotificationService(plugin);
});

/// Provider for the Notification Permission Service.
final notificationPermissionServiceProvider =
    Provider<NotificationPermissionService>((ref) {
  final plugin = ref.watch(flutterLocalNotificationsPluginProvider);
  return LocalNotificationPermissionService(plugin);
});
