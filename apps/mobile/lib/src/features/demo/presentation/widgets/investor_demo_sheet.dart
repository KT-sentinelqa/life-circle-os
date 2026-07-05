import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';

/// A bottom sheet designed for live investor pitches to securely
/// navigate between demo scenarios with presenter notes.
class InvestorDemoSheet extends ConsumerWidget {
  /// Creates an [InvestorDemoSheet].
  const InvestorDemoSheet({
    required this.currentScenario,
    required this.onScenarioSelected,
    super.key,
  });

  /// The currently active demo scenario.
  final DemoScenario currentScenario;

  /// Callback when a new scenario is tapped.
  final ValueChanged<DemoScenario> onScenarioSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Investor Demo Mode',
                  style: AppTypography.headlineLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Guided Pitch Walkthrough',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDemoStep(
              context,
              scenario: DemoScenario.healthyFamily,
              title: '1. The Baseline',
              note: 'Highlight the green gradient and perfect adherence.',
              icon: Icons.check_circle,
              color: AppColors.success,
            ),
            _buildDemoStep(
              context,
              scenario: DemoScenario.careNeeded,
              title: '2. The Escalation',
              note: 'Show how the UI shifts to Amber, prompting '
                  'caregiver action.',
              icon: Icons.warning_amber_rounded,
              color: AppColors.warning,
            ),
            _buildDemoStep(
              context,
              scenario: DemoScenario.criticalSituation,
              title: '3. The Crisis',
              note: 'Demonstrate the red alerts and immediate '
                  'notification triggers.',
              icon: Icons.error_outline,
              color: AppColors.error,
            ),
            _buildDemoStep(
              context,
              scenario: DemoScenario.livingAloneParent,
              title: '4. The Edge Case',
              note: 'Highlight remote monitoring for aging parents.',
              icon: Icons.elderly,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton.icon(
              onPressed: () {
                HapticFeedback.mediumImpact();
                onScenarioSelected(DemoScenario.healthyFamily);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.restore),
              label: const Text('Reset Demo to Baseline'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoStep(
    BuildContext context, {
    required DemoScenario scenario,
    required String title,
    required String note,
    required IconData icon,
    required Color color,
  }) {
    final isActive = currentScenario == scenario;
    return InkWell(
      onTap: () {
        HapticFeedback.mediumImpact();
        onScenarioSelected(scenario);
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.sm),
          border: Border.all(
            color: isActive
                ? color.withValues(alpha: 0.3)
                : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: isActive ? color : Colors.grey),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal,
                      color: isActive ? color : AppColors.textPrimaryLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note,
                    style: AppTypography.bodyLarge.copyWith(
                      fontSize: 14,
                      color: AppColors.textSecondaryLight,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive)
              const Icon(Icons.check, color: AppColors.success, size: 20),
          ],
        ),
      ),
    );
  }
}
