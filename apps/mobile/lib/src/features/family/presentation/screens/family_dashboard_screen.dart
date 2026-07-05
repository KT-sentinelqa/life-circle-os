import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_staggered_reveal.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/adherence_heatmap.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/weekly_insights_card.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_heatmap_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/presentation/providers/demo_seed_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_members_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/escalation_center_card.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/family_health_score_card.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/family_members_overview.dart';

/// Screen displaying the main family dashboard.
class FamilyDashboardScreen extends ConsumerStatefulWidget {
  /// Creates a [FamilyDashboardScreen].
  const FamilyDashboardScreen({super.key});

  @override
  ConsumerState<FamilyDashboardScreen> createState() =>
      _FamilyDashboardScreenState();
}

class _FamilyDashboardScreenState extends ConsumerState<FamilyDashboardScreen> {
  DemoScenario _currentScenario = DemoScenario.healthyFamily;

  @override
  Widget build(BuildContext context) {
    return LcScaffold(
      appBar: AppBar(
        title: const Text('LifeCircle Dashboard'),
        actions: [
          PopupMenuButton<DemoScenario>(
            icon: const Icon(Icons.bug_report, color: Colors.blueAccent),
            tooltip: 'Switch Demo Scenario',
            onSelected: (scenario) async {
              setState(() {
                _currentScenario = scenario;
              });
              await ref.read(demoSeedEngineProvider).populateDemoScenario(
                    scenario,
                    DateTime.now(),
                  );
              ref
                ..invalidate(familyHealthScoreProvider)
                ..invalidate(familyMembersProvider)
                ..invalidate(adherenceHeatmapProvider);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: DemoScenario.healthyFamily,
                child: Text('🟢 Healthy Family'),
              ),
              const PopupMenuItem(
                value: DemoScenario.careNeeded,
                child: Text('🟡 Care Needed'),
              ),
              const PopupMenuItem(
                value: DemoScenario.criticalSituation,
                child: Text('🔴 Critical Situation'),
              ),
              const PopupMenuItem(
                value: DemoScenario.livingAloneParent,
                child: Text('👴 Living Alone'),
              ),
            ],
          ),
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
      body: KeyedSubtree(
        key: ValueKey(_currentScenario),
        child: RefreshIndicator(
          onRefresh: () async {
            ref
              ..invalidate(familyHealthScoreProvider)
              ..invalidate(familyMembersProvider)
              ..invalidate(adherenceHeatmapProvider);
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
      ),
    );
  }
}
