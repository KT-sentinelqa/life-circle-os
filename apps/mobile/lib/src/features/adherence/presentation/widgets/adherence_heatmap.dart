import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_heatmap_provider.dart';

/// A GitHub-style contribution grid for adherence.
class AdherenceHeatmap extends ConsumerWidget {
  /// Creates an [AdherenceHeatmap].
  const AdherenceHeatmap({super.key, this.medicineId});

  /// The medicine ID to show heatmap for, or null for global.
  final String? medicineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatmapAsync =
        ref.watch(adherenceHeatmapProvider(medicineId: medicineId));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Adherence Heatmap',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            heatmapAsync.when(
              data: (records) {
                if (records.isEmpty) {
                  return const Text('No adherence records available.');
                }

                // Sort records by date ascending
                final sortedRecords = records.toList()
                  ..sort((a, b) => a.dateUtc.compareTo(b.dateUtc));

                return Semantics(
                  label: 'Adherence Heatmap Grid',
                  child: Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: sortedRecords.map((record) {
                      Color boxColor;
                      switch (record.status) {
                        case AdherenceStatus.perfect:
                          boxColor = Colors.green[800]!;
                        case AdherenceStatus.good:
                          boxColor = Colors.green[500]!;
                        case AdherenceStatus.atRisk:
                          boxColor = Colors.orange;
                        case AdherenceStatus.critical:
                          boxColor = Colors.red;
                        case AdherenceStatus.unknown:
                          boxColor = Colors.grey[300]!;
                      }

                      final dateStr = record.dateUtc.toIso8601String();
                      final dateLabel = dateStr.split('T').first;
                      final statusLabel = record.status.name;

                      return Semantics(
                        label: 'Date: $dateLabel, Status: $statusLabel',
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Text('Error loading heatmap: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
