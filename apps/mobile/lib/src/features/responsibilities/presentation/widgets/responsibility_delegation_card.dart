import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/entities/household_duty_entity.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/providers/household_duties_provider.dart';

/// A dashboard card displaying the breakdown of household responsibilities
/// by family member.
class ResponsibilityDelegationCard extends ConsumerWidget {
  /// Creates a [ResponsibilityDelegationCard].
  const ResponsibilityDelegationCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dutiesAsync = ref.watch(householdDutiesListProvider);

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
                const Icon(Icons.group, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Household Responsibilities',
                  style: AppTypography.headlineLarge.copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            dutiesAsync.when(
              data: (duties) {
                // Group by assigneeName
                final grouped = <String, List<HouseholdDutyEntity>>{};
                for (final duty in duties) {
                  grouped.putIfAbsent(duty.assigneeName, () => []).add(duty);
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: grouped.entries.map((entry) {
                    return _buildAssigneeSection(entry.key, entry.value);
                  }).toList(),
                );
              },
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

  Widget _buildAssigneeSection(
    String assigneeName,
    List<HouseholdDutyEntity> tasks,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$assigneeName:',
            style: AppTypography.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ...tasks.map(_buildTaskRow),
        ],
      ),
    );
  }

  Widget _buildTaskRow(HouseholdDutyEntity task) {
    if (task.specialEventDate != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            const Text('🎂', style: TextStyle(fontSize: 16)),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '${task.taskName} ${task.specialEventDate}',
              style: AppTypography.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            task.isCompleted ? Icons.check : Icons.circle_outlined,
            size: 16,
            color: task.isCompleted
                ? AppColors.success
                : AppColors.textSecondaryLight,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            task.taskName,
            style: AppTypography.bodyLarge.copyWith(
              color: task.isCompleted
                  ? AppColors.textPrimaryLight
                  : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
