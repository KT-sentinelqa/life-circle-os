import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_staggered_reveal.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/adherence_heatmap.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/weekly_insights_card.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_members_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/escalation_center_card.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/family_health_score_card.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/family_members_overview.dart';

/// Screen displaying the main family dashboard.
class FamilyDashboardScreen extends ConsumerWidget {
  /// Creates a [FamilyDashboardScreen].
  const FamilyDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LcScaffold(
      appBar: AppBar(
        title: const Text('LifeCircle Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.medication),
            onPressed: () => context.push('/medicine'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(familyHealthScoreProvider)
            ..invalidate(familyMembersProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: const [
            LcStaggeredReveal(index: 0, child: FamilyHealthScoreCard()),
            SizedBox(height: AppSpacing.xl),
            LcStaggeredReveal(index: 1, child: FamilyMembersOverview()),
            SizedBox(height: AppSpacing.xl),
            LcStaggeredReveal(index: 2, child: EscalationCenterCard()),
            SizedBox(height: AppSpacing.xl),
            LcStaggeredReveal(index: 3, child: AdherenceHeatmap()),
            SizedBox(height: AppSpacing.xl),
            LcStaggeredReveal(index: 4, child: WeeklyInsightsCard()),
            SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
