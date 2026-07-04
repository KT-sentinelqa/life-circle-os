import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/notification_payload.dart';
import 'package:lifecircle_mobile/src/core/notifications/models/scheduled_notification.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';

/// Service responsible for reconciling OS notifications with
/// repository state.
class NotificationRecoveryService {
  /// Creates a [NotificationRecoveryService].
  NotificationRecoveryService({
    required this.notificationService,
    required this.medicineRepository,
  });

  /// The notification service for OS-level interactions.
  final NotificationService notificationService;

  /// The repository for accessing domain state.
  final MedicineRepository medicineRepository;

  /// Generates a deterministic integer ID based on domain identifiers.
  static int generateDeterministicId(
    String familyId,
    String memberId,
    String medicineId,
    String reminderId,
  ) {
    // Combine strings and hash to ensure idempotency and reboot stability
    final key = '$familyId-$memberId-$medicineId-$reminderId';
    // Using simple hashcode. For production, a more robust int hash could be
    // used,
    // but Dart's String.hashCode is deterministic per execution.
    // Wait, String.hashCode is NOT deterministic across app restarts in Dart!
    // We must use a custom hash function for true determinism across reboots.
    var hash = 0;
    for (var i = 0; i < key.length; i++) {
      hash = 31 * hash + key.codeUnitAt(i);
    }
    // ensure it fits in 32-bit int since flutter_local_notifications uses
    // 32-bit int IDs on Android
    return hash & 0x7FFFFFFF; 
  }

  /// Synchronizes scheduled OS notifications with the source-of-truth
  /// repository.
  Future<void> recoverNotifications({
    required String familyId,
    required String memberId,
  }) async {
    final medicines = await medicineRepository.getMedicines(familyId, memberId);
    final medicineMap = {for (final m in medicines) m.id: m};

    final allReminders = await medicineRepository.getRemindersByStatuses(
      familyId,
      memberId,
      ReminderStatus.values, // fetch all to remove completed/missed
    );

    final osNotifications =
        await notificationService.getScheduledNotifications();
    final osNotificationIds = osNotifications.map((n) => n.id).toSet();

    for (final reminder in allReminders) {
      final notificationId = generateDeterministicId(
        familyId,
        memberId,
        reminder.medicineId,
        reminder.id,
      );

      final isPending = reminder.status == ReminderStatus.pending;
      final isSnoozed = reminder.status == ReminderStatus.snoozed;
      final requiresNotification = isPending || isSnoozed;

      if (requiresNotification) {
        if (!osNotificationIds.contains(notificationId)) {
          final medicine = medicineMap[reminder.medicineId];
          if (medicine == null) continue;

          final targetTime = isSnoozed && reminder.snoozedUntil != null
              ? reminder.snoozedUntil!
              : reminder.scheduledTimeUtc;

          final notification = ScheduledNotification(
            id: notificationId,
            title: 'Time for ${medicine.name}',
            body: 'Please take your scheduled dose.',
            scheduledAt: targetTime,
            payload: NotificationPayload(
              familyId: familyId,
              userId: memberId,
              medicineId: medicine.id,
              reminderId: reminder.id,
            ),
          );

          await notificationService.schedule(notification);
        }
      } else {
        // Not pending/snoozed (i.e. completed, missed, skipped)
        if (osNotificationIds.contains(notificationId)) {
          await notificationService.cancel(notificationId);
        }
      }
    }
  }
}
