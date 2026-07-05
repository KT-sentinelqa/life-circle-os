import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_metrics_provider.dart';

/// A card displaying high-level adherence percentage and doses taken/scheduled.
class AdherenceSummaryCard extends ConsumerWidget {
  /// Creates an [AdherenceSummaryCard].
  const AdherenceSummaryCard({super.key, this.medicineId});

  /// The medicine ID to show metrics for, or null for global metrics.
  final String? medicineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync =
        ref.watch(adherenceMetricsProvider(medicineId: medicineId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: metricsAsync.when(
          data: (metrics) {
            if (metrics == null) {
              return const Text('No adherence data available.');
            }

            final percentage = (metrics.adherencePercentage * 100).toInt();

            return Semantics(
              label: 'Adherence Summary: $percentage percent. '
                  '${metrics.totalDosesTaken} of '
                  '${metrics.totalDosesScheduled} doses taken.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adherence Summary (Last 30 Days)',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$percentage%',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Taken: ${metrics.totalDosesTaken}'),
                          Text('Scheduled: ${metrics.totalDosesScheduled}'),
                          Text('Missed: ${metrics.totalDosesMissed}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error loading metrics: $err'),
        ),
      ),
    );
  }
}
