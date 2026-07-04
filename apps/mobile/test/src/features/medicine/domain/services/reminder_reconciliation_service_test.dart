import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/reminder_reconciliation_service.dart';
import 'package:mocktail/mocktail.dart';

class MockMedicineRepository extends Mock implements MedicineRepository {}

class MockAppClock extends Mock implements AppClock {}

class FakeReminderEntity extends Fake implements ReminderEntity {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeReminderEntity());
  });

  group('ReminderReconciliationService', () {
    late MockMedicineRepository mockRepo;
    late MockAppClock mockClock;
    late ReminderReconciliationService service;

    setUp(() {
      mockRepo = MockMedicineRepository();
      mockClock = MockAppClock();
      service = ReminderReconciliationService(
        repository: mockRepo,
        clock: mockClock,
      );
    });

    test('marks pending reminders as missed if overdue', () async {
      final now = DateTime.utc(2026, 1, 1, 12, 0); // Noon
      when(() => mockClock.now()).thenReturn(now);

      final reminders = [
        ReminderEntity(
          id: 'r1',
          medicineId: 'm1',
          familyId: 'f1',
          memberId: 'u1',
          // Overdue (90 mins ago)
          scheduledTimeUtc: now.subtract(const Duration(minutes: 90)),
          createdAt: now,
          updatedAt: now,
        ),
        ReminderEntity(
          id: 'r2',
          medicineId: 'm2',
          familyId: 'f1',
          memberId: 'u1',
          // Not overdue yet (30 mins ago)
          scheduledTimeUtc: now.subtract(const Duration(minutes: 30)),
          createdAt: now,
          updatedAt: now,
        ),
      ];

      when(
        () => mockRepo.getRemindersByStatuses(
          'f1',
          'u1',
          [ReminderStatus.pending, ReminderStatus.snoozed],
        ),
      ).thenAnswer((_) async => reminders);
      when(() => mockRepo.markReminderMissed('r1')).thenAnswer((_) async {});

      await service.reconcileReminders(
        familyId: 'f1',
        memberId: 'u1',
        missedTolerance: const Duration(minutes: 60),
      );

      verify(() => mockRepo.markReminderMissed('r1')).called(1);
      verifyNever(() => mockRepo.markReminderMissed('r2'));
    });

    test('reverts snoozed reminders to pending if snooze expired', () async {
      final now = DateTime.utc(2026, 1, 1, 12, 0);
      when(() => mockClock.now()).thenReturn(now);

      final reminders = [
        ReminderEntity(
          id: 'r3',
          medicineId: 'm3',
          familyId: 'f1',
          memberId: 'u1',
          scheduledTimeUtc: now.subtract(const Duration(minutes: 30)),
          status: ReminderStatus.snoozed,
          snoozedUntil: now.subtract(const Duration(minutes: 5)), // Expired
          createdAt: now,
          updatedAt: now,
        ),
        ReminderEntity(
          id: 'r4',
          medicineId: 'm4',
          familyId: 'f1',
          memberId: 'u1',
          scheduledTimeUtc: now,
          status: ReminderStatus.snoozed,
          snoozedUntil: now.add(const Duration(minutes: 10)), // Not expired
          createdAt: now,
          updatedAt: now,
        ),
      ];

      when(
        () => mockRepo.getRemindersByStatuses(
          'f1',
          'u1',
          [ReminderStatus.pending, ReminderStatus.snoozed],
        ),
      ).thenAnswer((_) async => reminders);
      when(() => mockRepo.restoreReminderToPending(any()))
          .thenAnswer((_) async {});

      await service.reconcileReminders(familyId: 'f1', memberId: 'u1');

      verify(() => mockRepo.restoreReminderToPending('r3')).called(1);
    });
  });
}
