import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_members_provider.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_empty_state.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_skeleton.dart';

/// A horizontally scrolling list of family members.
class FamilyMembersOverview extends ConsumerWidget {
  /// Creates a [FamilyMembersOverview].
  const FamilyMembersOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(familyMembersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Family Members',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        membersAsync.when(
          data: (members) {
            if (members.isEmpty) {
              return LcEmptyState(
                icon: Icons.family_restroom,
                title: 'Build your care circle',
                subtitle:
                    'Invite parents, grandparents,\nor caregivers to get started.',
                ctaText: 'Add Family Member',
                onCtaPressed: () {},
              );
            }
            return SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: members.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.md),
                itemBuilder: (context, index) {
                  final member = members[index];
                  // Using truncated user ID as placeholder for name in MVP
                  final displayName = member.userId.length > 5
                      ? member.userId.substring(0, 5)
                      : member.userId;

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColors.primaryLight,
                        child: Text(
                          member.role.name[0].toUpperCase(),
                          style: AppTypography.headlineLarge.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        displayName.toUpperCase(),
                        style: AppTypography.bodyLarge,
                      ),
                      Text(
                        member.role.name,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.textSecondaryLight,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
          loading: () => SizedBox(
            height: 120,
            child: Row(
              children: List.generate(
                4,
                (index) => const Padding(
                  padding: EdgeInsets.only(right: AppSpacing.md),
                  child: Column(
                    children: [
                      LcSkeletonAvatar(size: 64),
                      SizedBox(height: AppSpacing.sm),
                      LcSkeletonBox(width: 48, height: 16),
                      SizedBox(height: 4),
                      LcSkeletonBox(width: 32, height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }
}
