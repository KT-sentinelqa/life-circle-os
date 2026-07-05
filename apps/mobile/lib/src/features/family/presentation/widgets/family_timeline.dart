import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/universal_timeline_provider.dart';

/// Vertical timeline for family events.
class FamilyTimeline extends ConsumerWidget {
  /// Creates a [FamilyTimeline].
  const FamilyTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timelineAsync = ref.watch(universalTimelineProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Universal Timeline',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryLight,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        timelineAsync.when(
          data: (events) {
            if (events.isEmpty) {
              return const Text('No upcoming responsibilities.');
            }
            return Column(
              children: events.asMap().entries.map((entry) {
                final index = entry.key;
                final event = entry.value;
                return _buildTimelineItem(
                  context,
                  time: _formatEventTime(event.time),
                  title: event.title,
                  icon: event.icon,
                  color: event.color,
                  isCompleted: event.isCompleted,
                  isLast: index == events.length - 1,
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Text('Failed to load timeline.'),
        ),
      ],
    );
  }

  String _formatEventTime(DateTime time) {
    final now = DateTime.now();
    final difference = time.difference(now);

    if (difference.isNegative && difference.inDays == 0) {
      return DateFormat('hh:mm a').format(time); // Today past
    }
    if (difference.inDays == 0) {
      return DateFormat('hh:mm a').format(time); // Today future
    }
    if (difference.inDays == 1) return 'Tomorrow';
    if (difference.inDays > 1) return '${difference.inDays} Days';

    return DateFormat('MMM dd').format(time);
  }

  Widget _buildTimelineItem(
    BuildContext context, {
    required String time,
    required String title,
    required IconData icon,
    required Color color,
    required bool isCompleted,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isCompleted
                    ? color.withValues(alpha: 0.1)
                    : AppColors.surfaceLight,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: AppColors.textSecondaryLight.withValues(alpha: 0.2),
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                title,
                style: AppTypography.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                  color: isCompleted
                      ? AppColors.textSecondaryLight
                      : AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                time,
                style: AppTypography.bodyLarge.copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
