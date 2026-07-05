import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Bootstraps the local notification system and timezone data.
class NotificationBootstrap {
  /// Initializes timezones and the notification plugin.
  static Future<void> initialize(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    // 1. Initialize timezone database
    tz.initializeTimeZones();

    // 2. Detect local device timezone
    try {
      final timeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZone.identifier));
    } catch (e) {
      // Fallback to UTC if detection fails (e.g. in tests)
      tz.setLocalLocation(tz.UTC);
    }

    // 3. Initialize the plugin
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
    );

    await plugin.initialize(initializationSettings);
  }
}
