import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/reminder_generation_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAppClock extends Mock implements AppClock {}

void main() {
  group('ReminderGenerationService', () {
    late MockAppClock mockClock;
    late ReminderGenerationService service;

    setUp(() {
      mockClock = MockAppClock();
      service = ReminderGenerationService(mockClock);
      
      when(() => mockClock.now()).thenReturn(
        DateTime.utc(2026, 1, 1, 10),
      ); // 10 AM
    });

    test(
      'generates reminders for future times on day 1, and all times after',
      () {
      final now = mockClock.now();
      final medicine = MedicineEntity(
        id: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        name: 'Aspirin',
        dosage: '100mg',
        form: 'Pill',
        instructions: 'Take with water',
        createdAtUtc: now,
        updatedAtUtc: now,
      );

      final schedule = DosageScheduleEntity(
        id: 's1',
        medicineId: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        frequencyPerDay: 2,
        timesOfDay: const ['08:00', '20:00'],
        specificDaysOfWeek: const [],
        remindersEnabled: true,
        createdAtUtc: now,
        updatedAtUtc: now,
      );

      final reminders = service.generateReminders(
        medicine: medicine,
        schedule: schedule,
        daysAhead: 3,
      );

      // Day 0: 08:00 (past), 20:00 (future) -> 1 reminder
      // Day 1: 08:00, 20:00 -> 2 reminders
      // Day 2: 08:00, 20:00 -> 2 reminders
      // Total: 5 reminders
      expect(reminders.length, 5);
      expect(reminders.first.scheduledTimeUtc, DateTime.utc(2026, 1, 1, 20));
      expect(reminders.first.status, ReminderStatus.pending);
    });

    test('returns empty list if reminders disabled', () {
      final now = mockClock.now();
      final medicine = MedicineEntity(
        id: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        name: 'Aspirin',
        dosage: '100mg',
        form: 'Pill',
        instructions: 'Take with water',
        createdAtUtc: now,
        updatedAtUtc: now,
      );

      final schedule = DosageScheduleEntity(
        id: 's1',
        medicineId: 'm1',
        familyId: 'f1',
        memberId: 'u1',
        frequencyPerDay: 2,
        timesOfDay: const ['08:00', '20:00'],
        specificDaysOfWeek: const [],
        remindersEnabled: false,
        createdAtUtc: now,
        updatedAtUtc: now,
      );

      final reminders = service.generateReminders(
        medicine: medicine,
        schedule: schedule,
      );

      expect(reminders, isEmpty);
    });
  });
}
