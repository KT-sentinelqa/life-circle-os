import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_members_provider.dart';

/// A hero card for the dashboard displaying personalized greetings and summary.
class DashboardHeroCard extends ConsumerWidget {
  /// Creates a [DashboardHeroCard].
  const DashboardHeroCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(familyMembersProvider);

    return Card(
      elevation: 0,
      color: AppColors.primaryLight.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Evening, Amit.',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            membersAsync.when(
              data: (members) => Text(
                'You are caring for ${members.length} family members.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              loading: () => const CircularProgressIndicator.adaptive(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildMetricRow(
              Icons.check_circle,
              '5 medicines taken today',
              AppColors.success,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildMetricRow(
              Icons.warning_amber_rounded,
              '1 medicine due in 20 minutes',
              AppColors.warning,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildMetricRow(
              Icons.credit_card,
              '2 financial commitments this week',
              AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                const Icon(Icons.favorite, color: AppColors.error, size: 24),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Everything important is under control.',
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
