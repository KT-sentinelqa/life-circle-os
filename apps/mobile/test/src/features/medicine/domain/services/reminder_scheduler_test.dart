import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/reminder_scheduler.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationService extends Mock implements NotificationService {}

class FakeNotificationRequest extends Fake implements NotificationRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeNotificationRequest());
  });

  group('ReminderScheduler', () {
    late MockNotificationService mockNotificationService;
    late ReminderScheduler scheduler;

    setUp(() {
      mockNotificationService = MockNotificationService();
      scheduler = ReminderScheduler(mockNotificationService);
    });

    test('scheduleReminders queues notifications correctly', () async {
      when(() => mockNotificationService.schedule(any()))
          .thenAnswer((_) async {});

      final medicine = MedicineEntity(
        id: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        name: 'Aspirin',
        dosage: '100mg',
        form: 'Pill',
        instructions: 'Take with water',
        createdAtUtc: DateTime.utc(2026),
        updatedAtUtc: DateTime.utc(2026),
      );

      final reminders = [
        ReminderEntity(
          id: 'r1',
          familyId: 'f1',
          memberId: 'u1',
          medicineId: 'm1',
          scheduledTimeUtc: DateTime.utc(2026, 1, 1, 8),
          createdAt: DateTime.utc(2026),
          updatedAt: DateTime.utc(2026),
        ),
        ReminderEntity(
          id: 'r2',
          familyId: 'f1',
          memberId: 'u1',
          medicineId: 'm1',
          scheduledTimeUtc: DateTime.utc(2026, 1, 1, 20),
          status: ReminderStatus.completed,
          createdAt: DateTime.utc(2026),
          updatedAt: DateTime.utc(2026),
        ),
      ];

      await scheduler.scheduleReminders(medicine, reminders);

      final captured = verify(
        () => mockNotificationService.schedule(captureAny()),
      ).captured;

      expect(captured.length, 1);
      final request = captured.first as NotificationRequest;
      expect(request.title, 'Time for Aspirin');
      expect(request.scheduledAt, DateTime.utc(2026, 1, 1, 8));
    });
  });
}
