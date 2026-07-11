import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/design_system/motion.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';

/// The Peace Index Card — the most important UI element in LifeCircle OS.
/// It communicates the family's collective confidence in one glance.
/// Philosophy: The number should feel like a resting heartbeat, not a grade.
class LCPeaceIndexCard extends StatelessWidget {
  const LCPeaceIndexCard({
    required this.score,
    required this.statusLabel,
    super.key,
    this.onTap,
  });
  final int score; // 0-100
  final String statusLabel;
  final VoidCallback? onTap;

  Color get _scoreColor {
    if (score >= 80) return LCColors.confidenceGreen;
    if (score >= 50) return LCColors.watchAmber;
    return LCColors.escalationRose;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: LCMotion.peaceIndexUpdate,
        curve: LCMotion.peaceIndexCurve,
        padding: const EdgeInsets.all(LCSpacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(LCRadius.xl),
          boxShadow: LCShadows.cardSubtle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: 'Family Peace Index Score',
              value: '$score out of 100',
              child: ExcludeSemantics(
                child: Text(
                  'Family Peace Index',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: LCSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AnimatedDefaultTextStyle(
                  duration: LCMotion.peaceIndexUpdate,
                  style: LCTextStyles.displayLarge.copyWith(color: _scoreColor),
                  child: Text('$score'),
                ),
                const SizedBox(width: LCSpacing.xs),
                Padding(
                  padding: const EdgeInsets.only(bottom: LCSpacing.sm),
                  child: Text(
                    '/100',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: LCSpacing.xs),
            Text(
              statusLabel,
              style: LCTextStyles.caption.copyWith(color: _scoreColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state for Peace Index when no responsibilities are configured.
class LCPeaceIndexEmpty extends StatelessWidget {
  const LCPeaceIndexEmpty({required this.onAddFirst, super.key});
  final VoidCallback onAddFirst;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LCSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.family_restroom_outlined,
            size: 64,
            color: LCColors.inkDisabled,
          ),
          const SizedBox(height: LCSpacing.md),
          Text(
            "Your family hasn't added any responsibilities yet.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: LCSpacing.lg),
          FilledButton(
            onPressed: onAddFirst,
            child: const Text('Add Your First Responsibility'),
          ),
        ],
      ),
    );
  }
}
