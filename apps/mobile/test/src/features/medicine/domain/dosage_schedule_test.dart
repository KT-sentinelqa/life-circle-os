import 'package:flutter_test/flutter_test.dart';

import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';

void main() {
  test('DosageScheduleEntity retains frequency and time of day', () {
    final now = DateTime.utc(2026);
    final schedule = DosageScheduleEntity(
      id: 's1',
      medicineId: 'm1',
      familyId: 'f1',
      memberId: 'u1',
      frequencyPerDay: 2,
      timesOfDay: const <String>['08:00', '20:00'],
      specificDaysOfWeek: const <int>[1, 2, 3, 4, 5, 6, 7],
      remindersEnabled: true,
      createdAtUtc: now,
      updatedAtUtc: now,
    );

    expect(schedule.timesOfDay.length, 2);
    expect(schedule.specificDaysOfWeek.length, 7);
    expect(schedule.remindersEnabled, true);
  });
}
