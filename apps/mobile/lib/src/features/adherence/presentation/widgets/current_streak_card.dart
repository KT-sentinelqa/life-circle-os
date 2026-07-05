import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/medicine_streak_provider.dart';

/// A widget emphasizing the current streak and longest streak.
class CurrentStreakCard extends ConsumerWidget {
  /// Creates a [CurrentStreakCard].
  const CurrentStreakCard({super.key, this.medicineId});

  /// The medicine ID to show the streak for, or null for global streak.
  final String? medicineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakAsync =
        ref.watch(medicineStreakProvider(medicineId: medicineId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: streakAsync.when(
          data: (streak) {
            if (streak == null) {
              return const Text('No streak data available.');
            }

            return Semantics(
              label: 'Current adherence streak: ${streak.currentStreak} days. '
                  'Longest streak: ${streak.longestStreak} days.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Streaks',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStreakIndicator(
                        context,
                        title: 'Current Streak',
                        value: streak.currentStreak,
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                      _buildStreakIndicator(
                        context,
                        title: 'Longest Streak',
                        value: streak.longestStreak,
                        icon: Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error loading streak: $err'),
        ),
      ),
    );
  }

  Widget _buildStreakIndicator(
    BuildContext context, {
    required String title,
    required int value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 48, color: color),
        const SizedBox(height: 8),
        Text(
          '$value Days',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(title, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
