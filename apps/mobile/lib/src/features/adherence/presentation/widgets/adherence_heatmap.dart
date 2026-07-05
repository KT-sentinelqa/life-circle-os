import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_status.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_heatmap_provider.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_empty_state.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_skeleton.dart';

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
                  return const LcEmptyState(
                    icon: Icons.calendar_month,
                    title: 'No adherence history yet',
                    subtitle: 'Take medicines consistently to unlock '
                        'insights and trends.',
                  );
                }

                // Sort records by date ascending
                final sortedRecords = records.toList()
                  ..sort((a, b) => a.dateUtc.compareTo(b.dateUtc));

                // Group into 7 rows by weekday
                final List<List<AdherenceRecord>> rows =
                    List<List<AdherenceRecord>>.generate(
                  7,
                  (_) => <AdherenceRecord>[],
                );
                for (final record in sortedRecords) {
                  // weekday 1 (Mon) -> index 0, weekday 7 (Sun) -> index 6
                  final rowIndex = record.dateUtc.weekday - 1;
                  rows[rowIndex].add(record);
                }

                return Semantics(
                  label: 'Adherence Heatmap Grid',
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(7, (rowIndex) {
                        final rowRecords = rows[rowIndex];
                        return _HeatmapRowReveal(
                          rowIndex: rowIndex,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: rowRecords.map<Widget>((record) {
                                var boxColor = Colors.grey[300]!;
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

                                final dateStr =
                                    record.dateUtc.toIso8601String();
                                final dateLabel = dateStr.split('T').first;
                                final statusLabel = record.status.name;

                                return Semantics(
                                  label:
                                      'Date: $dateLabel, Status: $statusLabel',
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: boxColor,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
              loading: () => const LcSkeletonCard(height: 200),
              error: (err, stack) => Text('Error loading heatmap: $err'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeatmapRowReveal extends StatefulWidget {
  const _HeatmapRowReveal({
    required this.child,
    required this.rowIndex,
  });

  final Widget child;
  final int rowIndex;

  @override
  State<_HeatmapRowReveal> createState() => _HeatmapRowRevealState();
}

class _HeatmapRowRevealState extends State<_HeatmapRowReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(Duration(milliseconds: widget.rowIndex * 40), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _slideAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
