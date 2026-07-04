import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'package:lifecircle_mobile/src/core/notifications/contracts/notification_service.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';

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
      if (reminder.isTaken) {
        continue;
      }

      final deterministicIdStr = _generateDeterministicId(
        familyId: reminder.familyId,
        memberId: reminder.memberId,
        medicineId: reminder.medicineId,
        scheduledAt: reminder.scheduledTimeUtc,
      );

      final request = NotificationRequest(
        id: deterministicIdStr,
        title: 'Time for ${medicine.name}',
        body: 'Please take your scheduled dose of ${medicine.dosage}.',
        scheduledAt: reminder.scheduledTimeUtc,
      );

      await notificationService.schedule(request);
    }
  }

  String _generateDeterministicId({
    required String familyId,
    required String memberId,
    required String medicineId,
    required DateTime scheduledAt,
  }) {
    final payload =
        '$familyId:$memberId:$medicineId:${scheduledAt.toIso8601String()}';
    final bytes = utf8.encode(payload);
    final digest = sha256.convert(bytes);

    return digest.toString();
  }
}
