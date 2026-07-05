import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_staggered_reveal.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_heatmap_provider.dart';

import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/presentation/providers/demo_seed_provider.dart';
import 'package:lifecircle_mobile/src/features/demo/presentation/widgets/investor_demo_sheet.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_members_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/dashboard_hero_card.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/family_members_overview.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/family_timeline.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/widgets/peace_of_mind_card.dart';
import 'package:lifecircle_mobile/src/features/finance/presentation/widgets/emi_intelligence_card.dart';
import 'package:lifecircle_mobile/src/features/protection/presentation/widgets/insurance_center_card.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/widgets/responsibility_delegation_card.dart';

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
          IconButton(
            icon: const Icon(Icons.present_to_all, color: Colors.blueAccent),
            tooltip: 'Investor Demo Mode',
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => InvestorDemoSheet(
                  currentScenario: _currentScenario,
                  onScenarioSelected: (scenario) async {
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
                ),
              );
            },
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
              LcStaggeredReveal(index: 0, child: DashboardHeroCard()),
              SizedBox(height: AppSpacing.xl),
              LcStaggeredReveal(index: 1, child: PeaceOfMindCard()),
              SizedBox(height: AppSpacing.xl),
              LcStaggeredReveal(index: 2, child: FamilyMembersOverview()),
              SizedBox(height: AppSpacing.xl),
              LcStaggeredReveal(index: 3, child: FamilyTimeline()),
              SizedBox(height: AppSpacing.xl),
              LcStaggeredReveal(index: 4, child: EmiIntelligenceCard()),
              SizedBox(height: AppSpacing.xl),
              LcStaggeredReveal(index: 5, child: InsuranceCenterCard()),
              SizedBox(height: AppSpacing.xl),
              LcStaggeredReveal(
                index: 6,
                child: ResponsibilityDelegationCard(),
              ),
              SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
