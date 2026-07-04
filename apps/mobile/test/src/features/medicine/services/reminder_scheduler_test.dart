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

  test('ReminderScheduler schedules notifications with deterministic IDs',
      () async {
    final mockService = MockNotificationService();
    when(() => mockService.schedule(any<NotificationRequest>()))
        .thenAnswer((_) async {});

    final scheduler = ReminderScheduler(mockService);

    final medicine = MedicineEntity(
      id: 'm1',
      familyId: 'f1',
      memberId: 'mem1',
      name: 'Aspirin',
      dosage: '100mg',
      form: 'Pill',
      instructions: 'Take with water',
      createdAtUtc: DateTime.utc(2026),
      updatedAtUtc: DateTime.utc(2026),
    );

    final reminder = ReminderEntity(
      id: 'r1',
      medicineId: 'm1',
      familyId: 'f1',
      memberId: 'mem1',
      scheduledTimeUtc: DateTime.utc(2026, 1, 1, 8),
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );

    await scheduler.scheduleReminders(medicine, <ReminderEntity>[reminder]);

    verify(() => mockService.schedule(any<NotificationRequest>())).called(1);
  });

  test('ReminderScheduler skips already taken reminders', () async {
    final mockService = MockNotificationService();
    final scheduler = ReminderScheduler(mockService);

    final medicine = MedicineEntity(
      id: 'm1',
      familyId: 'f1',
      memberId: 'mem1',
      name: 'Aspirin',
      dosage: '100mg',
      form: 'Pill',
      instructions: 'Take with water',
      createdAtUtc: DateTime.utc(2026),
      updatedAtUtc: DateTime.utc(2026),
    );

    final reminder = ReminderEntity(
      id: 'r1',
      medicineId: 'm1',
      familyId: 'f1',
      memberId: 'mem1',
      scheduledTimeUtc: DateTime.utc(2026, 1, 1, 8),
      status: ReminderStatus.completed,
      completedAt: DateTime.utc(2026, 1, 1, 8, 5),
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );

    await scheduler.scheduleReminders(medicine, <ReminderEntity>[reminder]);

    verifyNever(() => mockService.schedule(any<NotificationRequest>()));
  });
}
