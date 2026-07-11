import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecircle_mobile/src/design_system/motion.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';

/// A Responsibility Tile — displays a single family task with ownership.
/// Designed to communicate "someone has it covered" at a glance.
class LCResponsibilityTile extends StatelessWidget {
  const LCResponsibilityTile({
    required this.title,
    required this.primaryOwnerName,
    required this.isCompleted,
    required this.confidenceScore,
    super.key,
    this.backupOwnerName,
    this.onComplete,
    this.onTap,
  });
  final String title;
  final String primaryOwnerName;
  final String? backupOwnerName;
  final bool isCompleted;
  final int confidenceScore;
  final VoidCallback? onComplete;
  final VoidCallback? onTap;

  Color get _confidenceColor {
    if (confidenceScore >= 80) return LCColors.confidenceGreen;
    if (confidenceScore >= 50) return LCColors.watchAmber;
    return LCColors.escalationRose;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          '$title, owned by $primaryOwnerName, confidence $confidenceScore percent',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedOpacity(
          duration: LCMotion.taskResolved,
          opacity: isCompleted ? 0.6 : 1.0,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: LCSpacing.md,
              vertical: LCSpacing.xs,
            ),
            padding: const EdgeInsets.all(LCSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(LCRadius.lg),
              boxShadow: LCShadows.cardSubtle,
            ),
            child: Row(
              children: [
                // Completion Toggle
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    onComplete?.call();
                  },
                  child: AnimatedContainer(
                    duration: LCMotion.taskResolved,
                    curve: LCMotion.taskResolvedCurve,
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? LCColors.confidenceGreen
                          : Colors.transparent,
                      border: Border.all(
                        color: isCompleted
                            ? LCColors.confidenceGreen
                            : LCColors.inkDisabled,
                        width: 1.5,
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                ),
                const SizedBox(width: LCSpacing.md),
                // Title & Ownership
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  decoration: isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                      ),
                      const SizedBox(height: LCSpacing.xs),
                      Text(
                        backupOwnerName != null
                            ? '$primaryOwnerName · backup: $backupOwnerName'
                            : primaryOwnerName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // Confidence Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LCSpacing.sm,
                    vertical: LCSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: _confidenceColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(LCRadius.full),
                  ),
                  child: Text(
                    '$confidenceScore%',
                    style: LCTextStyles.label.copyWith(color: _confidenceColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
