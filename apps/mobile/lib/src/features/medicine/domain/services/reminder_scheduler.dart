import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/notification_payload.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/scheduled_notification.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/notification_recovery_service.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';

/// Service responsible for scheduling local medicine reminders.
class ReminderScheduler {
  /// Creates a [ReminderScheduler] with the given notification service.
  ReminderScheduler(this.notificationService);

  /// The underlying service used to dispatch local notifications.
  final NotificationService notificationService;

  /// Schedules deterministic reminders for a specific medicine.
  Future<void> scheduleReminders(
    MedicineEntity medicine,
    List<ReminderEntity> reminders,
  ) async {
    for (final reminder in reminders) {
      if (reminder.status != ReminderStatus.pending) {
        continue;
      }

      final deterministicId = NotificationRecoveryService.generateDeterministicId(
        reminder.familyId,
        reminder.memberId,
        reminder.medicineId,
        reminder.id,
      );

      final request = ScheduledNotification(
        id: deterministicId,
        title: 'Time for ${medicine.name}',
        body: 'Please take your scheduled dose of ${medicine.dosage}.',
        scheduledAt: reminder.scheduledTimeUtc,
        payload: NotificationPayload(
          familyId: reminder.familyId,
          userId: reminder.memberId,
          medicineId: reminder.medicineId,
          reminderId: reminder.id,
        ),
      );

      await notificationService.schedule(request);
    }
  }
}
