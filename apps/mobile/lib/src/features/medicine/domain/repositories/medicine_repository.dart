import 'package:lifecircle_mobile/src/features/medicine/domain/entities/dosage_schedule_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';

/// Abstract contract for managing medicine persistence and sync.
abstract interface class MedicineRepository {
  /// Retrieves a list of medicines belonging to a specific family member.
  Future<List<MedicineEntity>> getMedicines(
    String familyId,
    String memberId,
  );

  /// Saves a new medicine alongside its dosage schedule.
  Future<void> saveMedicine(
    MedicineEntity medicine,
    DosageScheduleEntity schedule,
  );

  /// Retrieves the dosage schedule for a specific medicine.
  Future<DosageScheduleEntity?> getDosageSchedule(String medicineId);

  /// Deletes a medicine and its associated schedule.
  Future<void> deleteMedicine(String medicineId);

  /// Saves a list of generated reminders to the repository.
  Future<void> saveReminders(List<ReminderEntity> reminders);

  /// Updates an existing reminder (e.g., status changes).
  Future<void> updateReminder(ReminderEntity reminder);

  /// Marks a reminder as completed.
  Future<void> markReminderCompleted(String reminderId, DateTime completedAt);

  /// Marks a reminder as skipped.
  Future<void> markReminderSkipped(String reminderId, DateTime skippedAt);

  /// Snoozes a reminder for a given duration.
  Future<void> snoozeReminder(String reminderId, Duration snoozeDuration);

  /// Marks a reminder as missed.
  Future<void> markReminderMissed(String reminderId);

  /// Restores a snoozed reminder to pending status.
  Future<void> restoreReminderToPending(String reminderId);

  /// Retrieves reminders for a specific family member matching given statuses.
  Future<List<ReminderEntity>> getRemindersByStatuses(
    String familyId,
    String memberId,
    List<ReminderStatus> statuses,
  );

  /// Retrieves reminders for a specific family member on a given date (UTC).
  Future<List<ReminderEntity>> getRemindersForDate(
    String familyId,
    String memberId,
    DateTime date,
  );

  /// Logs a medicine action (e.g., taken, missed, skipped).
  Future<void> logMedicineTaken(
    MedicineLogEntity log,
  );
}
