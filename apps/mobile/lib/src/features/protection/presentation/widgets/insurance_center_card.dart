import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scale_on_press.dart';
import 'package:lifecircle_mobile/src/features/protection/domain/entities/insurance_entity.dart';
import 'package:lifecircle_mobile/src/features/protection/presentation/providers/insurance_provider.dart';

/// A dashboard card summarizing upcoming insurance renewals.
class InsuranceCenterCard extends ConsumerWidget {
  /// Creates an [InsuranceCenterCard].
  const InsuranceCenterCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insAsync = ref.watch(insuranceListProvider);

    return LcScaleOnPress(
      onTap: () {},
      child: Card(
        elevation: 0,
        color: AppColors.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.textSecondaryLight.withValues(alpha: 0.1),
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shield, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Insurance Center',
                  style: AppTypography.headlineLarge.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            insAsync.when(
              data: (insurances) => Column(
                children: insurances.map(_buildInsuranceRow).toList(),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildInsuranceRow(InsuranceEntity insurance) {
    final daysUntilRenewal =
        insurance.renewalDate.difference(DateTime.now()).inDays;
    final isUrgent = daysUntilRenewal <= 30;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                insurance.name,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isUrgent
                    ? 'Expires in $daysUntilRenewal days'
                    : 'Renewal in $daysUntilRenewal days',
                style: AppTypography.bodyLarge.copyWith(
                  fontSize: 14,
                  color: isUrgent
                      ? AppColors.warning
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondaryLight,
          ),
        ],
      ),
    );
  }
}
