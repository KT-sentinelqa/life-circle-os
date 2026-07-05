import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';

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
              return Card(
                elevation: 0,
                color: AppColors.backgroundLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                  side: const BorderSide(color: AppColors.primaryLight),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.success),
                      SizedBox(width: AppSpacing.md),
                      Text(
                        'All clear. No pending escalations.',
                        style: AppTypography.bodyLarge,
                      ),
                    ],
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
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }
}
