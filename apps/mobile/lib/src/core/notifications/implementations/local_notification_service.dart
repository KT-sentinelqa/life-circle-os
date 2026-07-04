import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';

/// Local implementation of [NotificationService].
class LocalNotificationService implements NotificationService {
  /// Creates a [LocalNotificationService].
  LocalNotificationService(this._plugin);

  final FlutterLocalNotificationsPlugin _plugin;

  /// In-memory list of scheduled notifications (stub for Phase 3).
  final List<NotificationRequest> _pendingRequests = [];

  @override
  Future<void> schedule(NotificationRequest request) async {
    // Note: To schedule correctly, zonedSchedule and timezone packages
    // are required.
    // We store it in memory for testing and foundational architecture.
    _pendingRequests.add(request);
  }

  @override
  Future<void> cancel(String id) async {
    _pendingRequests.removeWhere((r) => r.id == id);
    await _plugin.cancel(id.hashCode);
  }

  @override
  Future<void> cancelAll() async {
    _pendingRequests.clear();
    await _plugin.cancelAll();
  }

  /// Returns all currently scheduled requests.
  List<NotificationRequest> getPendingRequests() {
    return List.unmodifiable(_pendingRequests);
  }
}
