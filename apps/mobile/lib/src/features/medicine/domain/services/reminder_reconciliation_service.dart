import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/time/app_clock.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';

/// Provider for the [ReminderReconciliationService].
final reminderReconciliationServiceProvider =
    Provider<ReminderReconciliationService>((ref) {
  return ReminderReconciliationService(
    repository: ref.watch(medicineRepositoryProvider),
    clock: ref.watch(appClockProvider),
  );
});

/// Service responsible for automatically progressing the temporal state
/// of reminders (e.g. marking overdue reminders as missed,
/// or expiring snoozes).
class ReminderReconciliationService {
  /// Creates a [ReminderReconciliationService].
  ReminderReconciliationService({
    required this.repository,
    required this.clock,
  });

  /// The repository for accessing and updating reminders.
  final MedicineRepository repository;

  /// The clock for determining current time.
  final AppClock clock;

  /// Reconciles all pending and snoozed reminders for a user.
  /// Overdue pending reminders are marked as missed.
  /// Expired snoozed reminders are moved back to pending.
  Future<void> reconcileReminders({
    required String familyId,
    required String memberId,
    Duration missedTolerance = const Duration(minutes: 60),
  }) async {
    final now = clock.now().toUtc();

    final reminders = await repository.getRemindersByStatuses(
      familyId,
      memberId,
      [ReminderStatus.pending, ReminderStatus.snoozed],
    );

    for (final reminder in reminders) {
      if (reminder.status == ReminderStatus.pending) {
        final expirationTime = reminder.scheduledTimeUtc.add(missedTolerance);
        if (now.isAfter(expirationTime)) {
          await repository.markReminderMissed(reminder.id);
        }
      } else if (reminder.status == ReminderStatus.snoozed) {
        final snoozedUntil = reminder.snoozedUntil;
        if (snoozedUntil != null && now.isAfter(snoozedUntil)) {
          await repository.restoreReminderToPending(reminder.id);
        }
      }
    }
  }
}
