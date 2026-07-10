import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design_system/tokens.dart';
import '../../../../design_system/widgets/lc_responsibility_tile.dart';
import '../../../../design_system/widgets/lc_interaction_system.dart';
import '../../application/responsibility_providers.dart';
import '../../domain/models/family_responsibility.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Milestone 2: Responsibilities screen wired to live Isar repository.
// Ordered by confidence score (Overdue → At Risk → Covered).
// Optimistic completion dispatches via ResponsibilityService.
// ─────────────────────────────────────────────────────────────────────────────

class ResponsibilitiesScreen extends ConsumerWidget {
  const ResponsibilitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsibilitiesAsync = ref.watch(familyResponsibilitiesProvider);

    return Scaffold(
      body: SafeArea(
        child: responsibilitiesAsync.when(
          loading: () => _LoadingState(),
          error: (e, _) => Center(
            child: LCInlineError(
              message: 'Something went wrong on our end. We\'re retrying.',
              onRetry: () => ref.refresh(familyResponsibilitiesProvider),
            ),
          ),
          data: (responsibilities) => _ResponsibilitiesList(
            responsibilities: responsibilities,
            ref: ref,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add-responsibility',
        onPressed: () {
          // Phase 6.7 M2: navigate to AddResponsibilitySheet
        },
        backgroundColor: LCColors.peacefulTeal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _ResponsibilitiesList extends StatelessWidget {
  final List<FamilyResponsibility> responsibilities;
  final WidgetRef ref;

  const _ResponsibilitiesList({
    required this.responsibilities,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    // Partition by confidence — FAMILY_OPERATING_MODEL.md ordering rule
    final overdue = responsibilities
        .where((r) => !r.isCompleted && r.confidenceScore < 50).toList();
    final atRisk  = responsibilities
        .where((r) => !r.isCompleted &&
            r.confidenceScore >= 50 && r.confidenceScore < 80).toList();
    final covered = responsibilities
        .where((r) => r.isCompleted || r.confidenceScore >= 80).toList();

    if (responsibilities.isEmpty) return const _EmptyState();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.md),
          sliver: SliverToBoxAdapter(
            child: Text('Responsibilities',
              style: Theme.of(context).textTheme.headlineLarge),
          ),
        ),
        if (overdue.isNotEmpty) ...[
          _sectionHeader(context, 'Needs Attention', LCColors.escalationRose),
          _sliverList(overdue),
        ],
        if (atRisk.isNotEmpty) ...[
          _sectionHeader(context, 'At Risk', LCColors.watchAmber),
          _sliverList(atRisk),
        ],
        if (covered.isNotEmpty) ...[
          _sectionHeader(context, 'Covered', LCColors.confidenceGreen),
          _sliverList(covered),
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  SliverPadding _sectionHeader(
      BuildContext context, String title, Color color) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.sm),
      sliver: SliverToBoxAdapter(
        child: Text(title,
          style: LCTextStyles.label.copyWith(color: color)),
      ),
    );
  }

  SliverList _sliverList(List<FamilyResponsibility> items) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) => LCResponsibilityTile(
          title: items[i].title,
          primaryOwnerName: items[i].primaryOwnerId,
          backupOwnerName: items[i].backupOwnerId,
          isCompleted: items[i].isCompleted,
          confidenceScore: items[i].confidenceScore,
          onComplete: () {
            // Optimistic update: dispatches to ResponsibilityService
            // which writes to Isar Outbox first, then syncs
            ref.read(responsibilityServiceProvider)
               .markComplete(items[i].uuid);
          },
        ),
        childCount: items.length,
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 80),
        LCResponsibilityTileSkeleton(),
        LCResponsibilityTileSkeleton(),
        LCResponsibilityTileSkeleton(),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LCSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline,
            size: 64, color: LCColors.inkDisabled),
          const SizedBox(height: LCSpacing.md),
          Text('No responsibilities yet.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: LCSpacing.sm),
          Text(
            'Add the things your family manages together — '
            'medicines, bills, documents.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
