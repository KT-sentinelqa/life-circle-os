import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:uuid/uuid.dart';

/// Service responsible for projecting dosage schedules into concrete reminders.
class ReminderGenerationService {
  /// Creates a [ReminderGenerationService] requiring a clock.
  ReminderGenerationService(this.clock);

  /// The application clock used for generating timestamps.
  final AppClock clock;

  /// Generates reminders for the next [daysAhead] days (default 7).
  List<ReminderEntity> generateReminders({
    required MedicineEntity medicine,
    required DosageScheduleEntity schedule,
    int daysAhead = 7,
  }) {
    if (!schedule.remindersEnabled || schedule.timesOfDay.isEmpty) {
      return const [];
    }

    final now = clock.now().toUtc();
    final reminders = <ReminderEntity>[];

    for (var i = 0; i < daysAhead; i++) {
      final day = now.add(Duration(days: i));
      
      for (final timeStr in schedule.timesOfDay) {
        final parts = timeStr.split(':');
        final hour = int.parse(parts[0]);
        final min = int.parse(parts[1]);
        
        final scheduledTime = DateTime.utc(
          day.year,
          day.month,
          day.day,
          hour,
          min,
        );

        if (scheduledTime.isAfter(now)) {
          reminders.add(
            ReminderEntity(
              id: const Uuid().v4(),
              familyId: medicine.familyId,
              memberId: medicine.memberId,
              medicineId: medicine.id,
              scheduledTimeUtc: scheduledTime,
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      }
    }
    
    return reminders;
  }
}
