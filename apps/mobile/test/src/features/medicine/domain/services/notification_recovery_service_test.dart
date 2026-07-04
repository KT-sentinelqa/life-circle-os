import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/notification_payload.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/scheduled_notification.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/notification_recovery_service.dart';

class MockNotificationService extends Mock implements NotificationService {}

class MockMedicineRepository extends Mock implements MedicineRepository {}

class FakeScheduledNotification extends Fake implements ScheduledNotification {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeScheduledNotification());
  });

  group('NotificationRecoveryService', () {
    late MockNotificationService mockNotificationService;
    late MockMedicineRepository mockRepo;
    late NotificationRecoveryService service;

    setUp(() {
      mockNotificationService = MockNotificationService();
      mockRepo = MockMedicineRepository();
      service = NotificationRecoveryService(
        notificationService: mockNotificationService,
        medicineRepository: mockRepo,
      );
    });

    test('generates deterministic ID correctly', () {
      final id1 = NotificationRecoveryService.generateDeterministicId('f1', 'u1', 'm1', 'r1');
      final id2 = NotificationRecoveryService.generateDeterministicId('f1', 'u1', 'm1', 'r1');
      expect(id1, id2);
    });

    test('recovers notifications correctly (adds missing, removes cancelled)', () async {
      final now = DateTime.utc(2026, 1, 1, 12);
      
      final medicines = [
        MedicineEntity(
          id: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          name: 'Aspirin',
          dosage: '100mg',
          form: 'Pill',
          instructions: '',
          createdAtUtc: now,
          updatedAtUtc: now,
        ),
      ];

      final reminders = [
        // Pending: should ensure notification exists
        ReminderEntity(
          id: 'r1',
          medicineId: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          scheduledTimeUtc: now.add(const Duration(hours: 1)),
          createdAt: now,
          updatedAt: now,
        ),
        // Completed: should ensure notification is removed
        ReminderEntity(
          id: 'r2',
          medicineId: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          scheduledTimeUtc: now.add(const Duration(hours: 2)),
          status: ReminderStatus.completed,
          createdAt: now,
          updatedAt: now,
        ),
      ];

      final id1 = NotificationRecoveryService.generateDeterministicId(
        'f1',
        'u1',
        'm1',
        'r1',
      );
      final id2 = NotificationRecoveryService.generateDeterministicId(
        'f1',
        'u1',
        'm1',
        'r2',
      );

      final osNotifications = [
        // Already exists for r2 (but r2 is completed, so it should be removed)
        ScheduledNotification(
          id: id2,
          title: 'Aspirin',
          body: 'Take it',
          scheduledAt: now,
          payload: const NotificationPayload(
            familyId: 'f1',
            userId: 'u1',
            medicineId: 'm1',
            reminderId: 'r2',
          ),
        ),
      ];

      when(() => mockRepo.getMedicines('f1', 'u1'))
          .thenAnswer((_) async => medicines);
      when(() => mockRepo.getRemindersByStatuses('f1', 'u1', any()))
          .thenAnswer((_) async => reminders);
      when(() => mockNotificationService.getScheduledNotifications())
          .thenAnswer((_) async => osNotifications);

      when(() => mockNotificationService.schedule(any()))
          .thenAnswer((_) async {});
      when(() => mockNotificationService.cancel(any()))
          .thenAnswer((_) async {});

      await service.recoverNotifications(familyId: 'f1', memberId: 'u1');

      // Should schedule r1
      verify(() => mockNotificationService.schedule(
        any(that: predicate<ScheduledNotification>((n) => n.id == id1)),
      )).called(1);

      // Should cancel r2
      verify(() => mockNotificationService.cancel(id2)).called(1);
    });
  });
}
