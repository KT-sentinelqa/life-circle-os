import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/notifications/implementations/local_notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/notification_payload.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/scheduled_notification.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class FakeTZDateTime extends Fake implements tz.TZDateTime {}

class FakeNotificationDetails extends Fake implements NotificationDetails {}

void main() {
  setUpAll(() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.UTC);

    registerFallbackValue(FakeTZDateTime());
    registerFallbackValue(FakeNotificationDetails());
    registerFallbackValue(UILocalNotificationDateInterpretation.absoluteTime);
    registerFallbackValue(AndroidScheduleMode.exactAllowWhileIdle);
  });

  group('LocalNotificationService', () {
    late MockFlutterLocalNotificationsPlugin mockPlugin;
    late LocalNotificationService service;

    setUp(() {
      mockPlugin = MockFlutterLocalNotificationsPlugin();
      service = LocalNotificationService(mockPlugin);
    });

    test('schedule delegates to zonedSchedule with correct parameters',
        () async {
      when(
        () => mockPlugin.zonedSchedule(
          any(),
          any(),
          any(),
          any(),
          any(),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          uiLocalNotificationDateInterpretation:
              any(named: 'uiLocalNotificationDateInterpretation'),
          payload: any(named: 'payload'),
        ),
      ).thenAnswer((_) async {});

      final notification = ScheduledNotification(
        id: 42,
        title: 'Title',
        body: 'Body',
        scheduledAt: DateTime.utc(2026, 1, 1, 12),
        payload: const NotificationPayload(
          familyId: 'f1',
          userId: 'u1',
          medicineId: 'm1',
          reminderId: 'r1',
        ),
      );

      await service.schedule(notification);

      verify(
        () => mockPlugin.zonedSchedule(
          42,
          'Title',
          'Body',
          any(that: isA<tz.TZDateTime>()),
          any(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: notification.payload.toJsonString(),
        ),
      ).called(1);
    });

    test('cancel delegates to plugin.cancel', () async {
      when(() => mockPlugin.cancel(42)).thenAnswer((_) async {});
      await service.cancel(42);
      verify(() => mockPlugin.cancel(42)).called(1);
    });

    test('cancelAll delegates to plugin.cancelAll', () async {
      when(() => mockPlugin.cancelAll()).thenAnswer((_) async {});
      await service.cancelAll();
      verify(() => mockPlugin.cancelAll()).called(1);
    });
  });
}
