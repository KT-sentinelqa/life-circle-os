import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecircle_mobile/src/design_system/motion.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SKELETON LOADER
// Replaces all bare spinners. Matches the shape of the expected content.
// Never shows a blank screen. Never shows a raw CircularProgressIndicator.
// ─────────────────────────────────────────────────────────────────────────────
class LCSkeleton extends StatefulWidget {
  const LCSkeleton({
    super.key,
    this.width = double.infinity,
    this.height = 16,
    this.borderRadius = 8,
  });
  final double width;
  final double height;
  final double borderRadius;

  @override
  State<LCSkeleton> createState() => _LCSkeletonState();
}

class _LCSkeletonState extends State<LCSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isDark ? LCColors.darkBorder : LCColors.borderSubtle,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

/// Skeleton for a full Responsibility Tile
class LCResponsibilityTileSkeleton extends StatelessWidget {
  const LCResponsibilityTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: LCSpacing.md,
        vertical: LCSpacing.xs,
      ),
      padding: const EdgeInsets.all(LCSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(LCRadius.lg),
      ),
      child: const Row(
        children: [
          LCSkeleton(width: 28, height: 28, borderRadius: 14),
          SizedBox(width: LCSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LCSkeleton(borderRadius: 4),
                SizedBox(height: LCSpacing.xs),
                LCSkeleton(width: 120, height: 12, borderRadius: 4),
              ],
            ),
          ),
          SizedBox(width: LCSpacing.md),
          LCSkeleton(width: 40, height: 24, borderRadius: 12),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// OPTIMISTIC COMPLETION BUTTON
// Responds immediately. Confirms locally. Syncs in background.
// ─────────────────────────────────────────────────────────────────────────────
class LCOptimisticCompleteButton extends StatefulWidget {
  const LCOptimisticCompleteButton({
    required this.isCompleted,
    required this.onToggle,
    super.key,
  });
  final bool isCompleted;
  final VoidCallback onToggle;

  @override
  State<LCOptimisticCompleteButton> createState() =>
      _LCOptimisticCompleteButtonState();
}

class _LCOptimisticCompleteButtonState extends State<LCOptimisticCompleteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: LCMotion.taskResolved,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: LCMotion.taskResolvedCurve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.mediumImpact();
    _controller.forward().then((_) => _controller.reverse());
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: LCMotion.taskResolved,
          curve: LCMotion.taskResolvedCurve,
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isCompleted
                ? LCColors.confidenceGreen
                : Colors.transparent,
            border: Border.all(
              color: widget.isCompleted
                  ? LCColors.confidenceGreen
                  : LCColors.inkDisabled,
              width: 1.5,
            ),
          ),
          child: widget.isCompleted
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INLINE ERROR STATE
// Never a full-screen error. Always inline, always with a recovery action.
// ─────────────────────────────────────────────────────────────────────────────
class LCInlineError extends StatelessWidget {
  const LCInlineError({
    required this.message,
    super.key,
    this.onRetry,
  });
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(LCSpacing.md),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_outlined,
            color: LCColors.watchAmber,
            size: 20,
          ),
          const SizedBox(width: LCSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: LCTextStyles.bodyMedium.copyWith(
                color: LCColors.inkSecondary,
              ),
            ),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }
}
