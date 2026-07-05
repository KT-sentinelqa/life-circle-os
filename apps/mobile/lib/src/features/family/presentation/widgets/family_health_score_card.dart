import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_health_provider.dart';

/// Card that visualizes the overall family health score and risk level.
class FamilyHealthScoreCard extends ConsumerWidget {
  /// Creates a [FamilyHealthScoreCard].
  const FamilyHealthScoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final healthScoreAsync = ref.watch(familyHealthScoreProvider);

    return Card(
      elevation: 0,
      color: AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.md),
        side: const BorderSide(color: AppColors.primaryLight),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: healthScoreAsync.when(
          data: (score) {
            if (score == null) {
              return const Center(child: Text('No family data available.'));
            }

            final percentage = (score.adherencePercentage * 100).round();
            var statusColor = AppColors.success;
            var statusText = 'Excellent';

            if (percentage < 50) {
              statusColor = AppColors.error;
              statusText = 'Critical';
            } else if (percentage < 80) {
              statusColor = AppColors.warning;
              statusText = 'Needs Attention';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Family Health Score',
                  style: AppTypography.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$percentage%',
                          style: AppTypography.displayMedium.copyWith(
                            color: statusColor,
                          ),
                        ),
                        Text(
                          statusText,
                          style: AppTypography.bodyLarge.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        value: score.adherencePercentage,
                        color: statusColor,
                        backgroundColor: statusColor.withValues(alpha: 0.2),
                        strokeWidth: 8,
                      ),
                    ),
                  ],
                ),
                if (score.membersAtRisk > 0) ...[
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            '${score.membersAtRisk} member(s) at risk',
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.xl),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }
}
