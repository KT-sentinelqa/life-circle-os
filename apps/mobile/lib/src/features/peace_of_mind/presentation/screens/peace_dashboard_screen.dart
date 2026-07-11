import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/peace_of_mind/application/peace_index_providers.dart';
import 'package:lifecircle_mobile/src/features/peace_of_mind/presentation/widgets/confidence_indicator.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/application/responsibility_providers.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_status.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/widgets/responsibility_card.dart';

class PeaceDashboardScreen extends ConsumerWidget {
  // Provided by auth layer

  const PeaceDashboardScreen({required this.currentUserId, super.key});
  final String currentUserId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final peaceScore = ref.watch(peaceIndexProvider(currentUserId));
    final responsibilitiesAsync = ref.watch(familyResponsibilitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exception Dashboard'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: ConfidenceIndicator(score: peaceScore),
              ),
            ),
          ),
          responsibilitiesAsync.when(
            data: (responsibilities) {
              // The Exception Dashboard paradigm: Only show escalated tasks
              final escalatedTasks = responsibilities
                  .where((r) => r.status == ResponsibilityStatus.escalated)
                  .toList();

              if (escalatedTasks.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(
                      child: Text(
                        'All Clear. No exceptions require your attention.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final resp = escalatedTasks[index];
                    return ResponsibilityCard(
                      responsibility: resp,
                      onMarkComplete: () {}, // Handled by actual implementation
                      onSkip: () {},
                    );
                  },
                  childCount: escalatedTasks.length,
                ),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(child: Text('Error loading dashboard: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
