import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/weekly_insights_provider.dart';

/// Displays actionable insights text for adherence.
class WeeklyInsightsCard extends ConsumerWidget {
  /// Creates a [WeeklyInsightsCard].
  const WeeklyInsightsCard({super.key, this.medicineId});

  /// The medicine ID to show insights for, or null for global insights.
  final String? medicineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insightsAsync =
        ref.watch(weeklyInsightsProvider(medicineId: medicineId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: insightsAsync.when(
          data: (insight) {
            if (insight == null || insight.isEmpty) {
              return const SizedBox.shrink();
            }

            return Semantics(
              label: 'Weekly Insight: $insight',
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, color: Colors.yellow, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      insight,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error loading insights: $err'),
        ),
      ),
    );
  }
}
