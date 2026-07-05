import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/entities/emi_entity.dart';
import 'package:lifecircle_mobile/src/features/finance/presentation/providers/emi_provider.dart';

/// A dashboard card summarizing upcoming financial EMI commitments.
class EmiIntelligenceCard extends ConsumerWidget {
  /// Creates an [EmiIntelligenceCard].
  const EmiIntelligenceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emiAsync = ref.watch(emiListProvider);

    return Card(
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
                const Icon(Icons.account_balance, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'EMI Intelligence',
                  style: AppTypography.headlineLarge.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            emiAsync.when(
              data: (emis) => Column(
                children: emis.map(_buildEmiRow).toList(),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmiRow(EmiEntity emi) {
    final currencyFormat = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    final daysUntilDue = emi.dueDate.difference(DateTime.now()).inDays;
    final isUpcoming = daysUntilDue <= 7;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                emi.name,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isUpcoming ? 'Due in $daysUntilDue days' : 'Due next month',
                style: AppTypography.bodyLarge.copyWith(
                  fontSize: 14,
                  color: isUpcoming
                      ? AppColors.warning
                      : AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
          Text(
            currencyFormat.format(emi.amount),
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
