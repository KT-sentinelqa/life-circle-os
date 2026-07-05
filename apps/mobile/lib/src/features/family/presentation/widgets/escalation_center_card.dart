import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_empty_state.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_skeleton.dart';

/// Displays actionable alerts and escalation tasks for caregivers.
class EscalationCenterCard extends ConsumerWidget {
  /// Creates an [EscalationCenterCard].
  const EscalationCenterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthScoreAsync = ref.watch(familyHealthScoreProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Escalation Center',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        healthScoreAsync.when(
          data: (score) {
            if (score == null || score.membersAtRisk == 0) {
              return const Card(
                elevation: 0,
                color: AppColors.backgroundLight,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: LcEmptyState(
                    icon: Icons.shield_moon,
                    title: 'Everything looks good today',
                    subtitle: 'No family members need attention.',
                    accentColor: AppColors.success,
                    iconColor: AppColors.success,
                  ),
                ),
              );
            }

            return Card(
              elevation: 0,
              color: AppColors.error.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                side: BorderSide(color: AppColors.error.withValues(alpha: 0.5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.warning, color: AppColors.error),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            'Critical Alerts (${score.membersAtRisk})',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Resolve'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.medication),
                      title: Text('Missed Doses Detected'),
                      subtitle: Text('Please check on assigned members.'),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const LcSkeletonCard(height: 120),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }
}
