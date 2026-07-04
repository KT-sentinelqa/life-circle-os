import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_entity.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/reminder_status.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/today_reminders_provider.dart';

/// Extension to group and filter reminders for the Today dashboard.
extension ReminderGrouping on List<ReminderEntity> {
  /// Returns only the reminders that are still pending.
  List<ReminderEntity> get upcoming {
    return where((r) => r.status == ReminderStatus.pending).toList();
  }

  /// Returns only the reminders that have been completed.
  List<ReminderEntity> get completed {
    return where((r) => r.status == ReminderStatus.completed).toList();
  }

  /// Returns only the reminders that were missed.
  List<ReminderEntity> get missed {
    return where((r) => r.status == ReminderStatus.missed).toList();
  }
}

/// A dashboard view displaying today's medication schedule.
class TodayMedicationsView extends StatelessWidget {
  /// Creates a [TodayMedicationsView].
  const TodayMedicationsView({
    required this.reminders,
    super.key,
  });

  /// The list of reminders for today.
  final List<ReminderEntity> reminders;

  @override
  Widget build(BuildContext context) {
    if (reminders.isEmpty) {
      return const Center(
        child: Text('No medications scheduled for today.'),
      );
    }

    final upcoming = reminders.upcoming;
    final completed = reminders.completed;
    final missed = reminders.missed;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (missed.isNotEmpty) ...[
          const _SectionHeader(title: 'Missed', color: Colors.red),
          ...missed.map((r) => _ReminderCard(reminder: r)),
          const SizedBox(height: 16),
        ],
        if (upcoming.isNotEmpty) ...[
          const _SectionHeader(title: 'Upcoming', color: Colors.blue),
          ...upcoming.map((r) => _ReminderCard(reminder: r)),
          const SizedBox(height: 16),
        ],
        if (completed.isNotEmpty) ...[
          const _SectionHeader(title: 'Completed', color: Colors.green),
          ...completed.map((r) => _ReminderCard(reminder: r)),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.color});
  
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _ReminderCard extends ConsumerWidget {
  const _ReminderCard({required this.reminder});

  final ReminderEntity reminder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeString = reminder.scheduledTimeUtc
        .toLocal()
        .toString()
        .substring(11, 16);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time: $timeString',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(reminder.status.name.toUpperCase()),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Medicine ID: ${reminder.medicineId}',
            ), 
            const SizedBox(height: 12),
            if (reminder.status == ReminderStatus.pending)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      ref.read(todayRemindersProvider.notifier).snoozeReminder(
                            reminder.id,
                            const Duration(minutes: 15),
                          );
                    },
                    child: const Text('Snooze'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(todayRemindersProvider.notifier)
                          .skipReminder(reminder.id);
                    },
                    child: const Text('Skip'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(todayRemindersProvider.notifier)
                          .takeReminder(reminder.id);
                    },
                    child: const Text('Take'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
