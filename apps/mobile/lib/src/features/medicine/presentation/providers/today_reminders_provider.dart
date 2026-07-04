import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/reminder_reconciliation_service.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';

/// Provider for fetching today's medication reminders.
final todayRemindersProvider = AutoDisposeAsyncNotifierProvider<
    TodayRemindersNotifier, List<ReminderEntity>>(
  TodayRemindersNotifier.new,
);

/// Notifier that manages the state of today's reminders.
class TodayRemindersNotifier
    extends AutoDisposeAsyncNotifier<List<ReminderEntity>> {
  @override
  Future<List<ReminderEntity>> build() async {
    final user = ref.watch(authProvider).valueOrNull;
    if (user == null || user.familyId == null) {
      return [];
    }

    // Reconcile missed/snoozed reminders before loading the UI state.
    final reconciler = ref.watch(reminderReconciliationServiceProvider);
    await reconciler.reconcileReminders(
      familyId: user.familyId!,
      memberId: user.id,
    );

    final clock = ref.watch(appClockProvider);
    final repository = ref.watch(medicineRepositoryProvider);

    return repository.getRemindersForDate(
      user.familyId!,
      user.id,
      clock.now().toUtc(),
    );
  }

  /// Refreshes the list of reminders for today.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(build);
  }

  /// Marks a reminder as taken.
  Future<void> takeReminder(String id) async {
    final repository = ref.read(medicineRepositoryProvider);
    final clock = ref.read(appClockProvider);
    await repository.markReminderCompleted(id, clock.now().toUtc());
    await refresh();
  }

  /// Marks a reminder as skipped.
  Future<void> skipReminder(String id) async {
    final repository = ref.read(medicineRepositoryProvider);
    final clock = ref.read(appClockProvider);
    await repository.markReminderSkipped(id, clock.now().toUtc());
    await refresh();
  }

  /// Snoozes a reminder for the given duration.
  Future<void> snoozeReminder(String id, Duration duration) async {
    final repository = ref.read(medicineRepositoryProvider);
    await repository.snoozeReminder(id, duration);
    await refresh();
  }
}
