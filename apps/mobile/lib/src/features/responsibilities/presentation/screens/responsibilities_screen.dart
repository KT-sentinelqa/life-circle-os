import 'package:flutter/material.dart';
import '../../design_system/tokens.dart';
import '../../design_system/widgets/lc_responsibility_tile.dart';

/// The Responsibilities Screen — all domains in one list.
///
/// Emotional contract: Families should feel "everything important
/// is accounted for," not overwhelmed by a task manager.
///
/// Ordering rule (FAMILY_OPERATING_MODEL.md):
///   1. Overdue / escalated (escalationRose)
///   2. Due today / watchAmber
///   3. All others (confidence ≥ 80)
class ResponsibilitiesScreen extends StatelessWidget {
  final List<ResponsibilityItem> responsibilities;
  final VoidCallback onAddNew;

  const ResponsibilitiesScreen({
    super.key,
    required this.responsibilities,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    final overdue  = responsibilities.where((r) => r.confidenceScore < 50).toList();
    final atRisk   = responsibilities.where((r) =>
        r.confidenceScore >= 50 && r.confidenceScore < 80).toList();
    final covered  = responsibilities.where((r) => r.confidenceScore >= 80).toList();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.md),
              sliver: SliverToBoxAdapter(
                child: Text('Responsibilities',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ),

            // Section: Needs Attention
            if (overdue.isNotEmpty)
              _SectionHeader(title: 'Needs Attention', color: LCColors.escalationRose),
            if (overdue.isNotEmpty)
              SliverList(delegate: SliverChildBuilderDelegate(
                (ctx, i) => LCResponsibilityTile(
                  title: overdue[i].title,
                  primaryOwnerName: overdue[i].primaryOwner,
                  backupOwnerName: overdue[i].backupOwner,
                  isCompleted: overdue[i].isCompleted,
                  confidenceScore: overdue[i].confidenceScore,
                ),
                childCount: overdue.length,
              )),

            // Section: At Risk
            if (atRisk.isNotEmpty)
              _SectionHeader(title: 'At Risk', color: LCColors.watchAmber),
            if (atRisk.isNotEmpty)
              SliverList(delegate: SliverChildBuilderDelegate(
                (ctx, i) => LCResponsibilityTile(
                  title: atRisk[i].title,
                  primaryOwnerName: atRisk[i].primaryOwner,
                  backupOwnerName: atRisk[i].backupOwner,
                  isCompleted: atRisk[i].isCompleted,
                  confidenceScore: atRisk[i].confidenceScore,
                ),
                childCount: atRisk.length,
              )),

            // Section: Covered
            if (covered.isNotEmpty)
              _SectionHeader(title: 'Covered', color: LCColors.confidenceGreen),
            if (covered.isNotEmpty)
              SliverList(delegate: SliverChildBuilderDelegate(
                (ctx, i) => LCResponsibilityTile(
                  title: covered[i].title,
                  primaryOwnerName: covered[i].primaryOwner,
                  backupOwnerName: covered[i].backupOwner,
                  isCompleted: covered[i].isCompleted,
                  confidenceScore: covered[i].confidenceScore,
                ),
                childCount: covered.length,
              )),

            // Empty state
            if (responsibilities.isEmpty)
              SliverFillRemaining(
                child: _EmptyResponsibilities(onAdd: onAddNew),
              ),

            // Bottom padding for FAB
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddNew,
        backgroundColor: LCColors.peacefulTeal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Responsibility',
          style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color color;
  const _SectionHeader({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        LCSpacing.md, LCSpacing.lg, LCSpacing.md, LCSpacing.sm),
      sliver: SliverToBoxAdapter(
        child: Text(title,
          style: LCTextStyles.label.copyWith(
            color: color, letterSpacing: 0.8),
        ),
      ),
    );
  }
}

class _EmptyResponsibilities extends StatelessWidget {
  final VoidCallback onAdd;
  const _EmptyResponsibilities({required this.onAdd});

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
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: LCSpacing.sm),
          Text('Add the things your family manages together — medicines, bills, documents.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: LCSpacing.lg),
          FilledButton(onPressed: onAdd,
            child: const Text('Add Your First Responsibility')),
        ],
      ),
    );
  }
}

class ResponsibilityItem {
  final String title;
  final String primaryOwner;
  final String? backupOwner;
  final bool isCompleted;
  final int confidenceScore;
  const ResponsibilityItem({
    required this.title,
    required this.primaryOwner,
    this.backupOwner,
    required this.isCompleted,
    required this.confidenceScore,
  });
}
