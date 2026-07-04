import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';

/// Local implementation of [NotificationService].
class LocalNotificationService implements NotificationService {
  /// Creates a [LocalNotificationService].
  const LocalNotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<void> schedule(NotificationRequest request) async {
    // Note: To schedule correctly, zonedSchedule and timezone packages
    // are required.
    // The implementation here would translate string IDs to deterministic
    // integers using request.id.hashCode.
    
    // For V1 compliance, we simulate scheduling or throw if timezone is absent.
    // We will leave this stubbed since we don't have timezone package.
    throw UnimplementedError(
      'Timezone-aware scheduling requires timezone package',
    );
  }

  @override
  Future<void> cancel(String id) async {
    await _plugin.cancel(id.hashCode);
  }

  @override
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
