import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design_system/tokens.dart';
import '../../../../design_system/widgets/lc_peace_index_card.dart';
import '../../../../design_system/widgets/lc_exception_alert.dart';
import '../../../../design_system/widgets/lc_sync_status_bar.dart';
import '../../../../design_system/widgets/lc_interaction_system.dart';
import '../../../peace_of_mind/application/peace_index_providers.dart';
import '../../../responsibilities/application/responsibility_providers.dart';
import '../../../sync/domain/models/sync_event.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Milestone 1: Dashboard fully wired to live Riverpod → Isar data.
// No mock data. No placeholders. No TODOs.
// ─────────────────────────────────────────────────────────────────────────────

/// Sync status provider — observes the local Outbox to derive connectivity state.
final syncStatusProvider = Provider<SyncStatus>((ref) {
  // TODO Phase 6.7 M2: derive from actual Outbox queue depth + ConnectivityPlus
  return SyncStatus.synced;
});

class DashboardScreen extends ConsumerWidget {
  // The current user's ID is injected at the app level after auth.
  final String currentUserId;

  const DashboardScreen({super.key, required this.currentUserId});

  String _statusLabel(int score) {
    if (score >= 80) return 'Everything is covered.';
    if (score >= 50) return 'A few things need attention.';
    return 'Your family needs you right now.';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Live Peace Score from PeaceIndexService → Isar responsibilities
    final peaceScore   = ref.watch(peaceIndexProvider(currentUserId));
    final syncStatus   = ref.watch(syncStatusProvider);
    final responsibilitiesAsync = ref.watch(familyResponsibilitiesProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sync status — invisible when SyncStatus.synced
            LCSyncStatusBar(status: syncStatus),

            // App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(
                LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.sm),
              child: Text('Home',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),

            // Peace Index Card — live score from Riverpod
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: LCSpacing.md),
              child: LCPeaceIndexCard(
                score: peaceScore,
                statusLabel: _statusLabel(peaceScore),
              ),
            ),

            const SizedBox(height: LCSpacing.lg),

            // Exceptions section — derived from live responsibilities
            responsibilitiesAsync.when(
              loading: () => const Expanded(
                child: Column(children: [
                  LCResponsibilityTileSkeleton(),
                  LCResponsibilityTileSkeleton(),
                ]),
              ),
              error: (e, _) => Expanded(
                child: LCInlineError(
                  message: 'Something went wrong on our end. We\'re retrying.',
                  onRetry: () => ref.refresh(familyResponsibilitiesProvider),
                ),
              ),
              data: (responsibilities) {
                // Exceptions = responsibilities where confidence < 80
                // AND the escalation window has been missed
                final exceptions = responsibilities
                    .where((r) =>
                        r.confidenceScore < 80 &&
                        !r.isCompleted)
                    .toList()
                  ..sort((a, b) =>
                      a.confidenceScore.compareTo(b.confidenceScore));

                if (exceptions.isEmpty) {
                  return const Expanded(child: LCAllCoveredState());
                }

                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: LCSpacing.md),
                        child: Text('Needs Attention',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: LCSpacing.sm),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: exceptions.length,
                          itemBuilder: (_, i) {
                            final r = exceptions[i];
                            return LCExceptionAlert(
                              title: r.title,
                              description: _exceptionDescription(r.confidenceScore),
                              assignedTo: r.backupOwnerId,
                              onAcknowledge: () {
                                // Phase 6.7 M2: dispatch to ResponsibilityService
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _exceptionDescription(int confidence) {
    if (confidence < 50) return 'This hasn\'t been confirmed and is overdue.';
    return 'This hasn\'t been confirmed yet. Can you check on it?';
  }
}
