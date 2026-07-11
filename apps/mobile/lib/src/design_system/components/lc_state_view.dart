import 'package:flutter/material.dart';
import '../tokens/lc_spacing.dart';
import '../tokens/lc_colors.dart';
import '../tokens/lc_animation.dart';
import '../tokens/lc_typography.dart';

/// LcStateView — LifeCircle Design System
///
/// The universal state presentation component. Every data-bearing screen must
/// use this component to represent non-content states.
///
/// UX Constitution: Every component must define consistent visuals for:
///   loading / empty / success / error / offline / syncing
///
/// Named constructors make the intended state self-documenting.
class LcStateView extends StatelessWidget {
  const LcStateView._({
    required this.icon,
    required this.title,
    this.subtitle,
    this.action,
    this.iconColor,
    super.key,
  });

  // ── Loading ──────────────────────────────────────────────────
  factory LcStateView.loading({
    String title = 'Loading…',
    Key? key,
  }) => _LcLoadingStateView(title: title, key: key);

  // ── Empty ────────────────────────────────────────────────────
  factory LcStateView.empty({
    required String title,
    String? subtitle,
    Widget? action,
    Key? key,
  }) => LcStateView._(
    icon: Icons.inbox_outlined,
    title: title,
    subtitle: subtitle,
    action: action,
    iconColor: LcColors.neutral400,
    key: key,
  );

  // ── Error ────────────────────────────────────────────────────
  factory LcStateView.error({
    String title = 'Something went wrong',
    String? subtitle,
    Widget? action,
    Key? key,
  }) => LcStateView._(
    icon: Icons.error_outline_rounded,
    title: title,
    subtitle: subtitle,
    action: action,
    iconColor: LcColors.error500,
    key: key,
  );

  // ── Offline ──────────────────────────────────────────────────
  factory LcStateView.offline({
    String title = 'You\'re offline',
    String subtitle = 'Your changes are saved and will sync when reconnected.',
    Widget? action,
    Key? key,
  }) => LcStateView._(
    icon: Icons.cloud_off_outlined,
    title: title,
    subtitle: subtitle,
    action: action,
    iconColor: LcColors.offline,
    key: key,
  );

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? action;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final textTheme   = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(LcSpacing.xl2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: iconColor ?? colorScheme.primary),
              const SizedBox(height: LcSpacing.md),
              Text(
                title,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: LcSpacing.xs),
                Text(
                  subtitle!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: LcSpacing.xl),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Internal shimmer loading variant — separated to keep the build method clean.
class _LcLoadingStateView extends LcStateView {
  const _LcLoadingStateView({required String title, super.key})
      : super._(
          icon: Icons.hourglass_empty_rounded,
          title: title,
        );

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: 'Loading content',
      child: Center(
        child: _ShimmerPlaceholder(),
      ),
    );
  }
}

/// Shimmer skeleton card — communicates loading state without spinner fatigue.
class _ShimmerPlaceholder extends StatefulWidget {
  @override
  State<_ShimmerPlaceholder> createState() => _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<_ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: LcAnimation.shimmerDuration,
    )..repeat();
    _animation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: LcAnimation.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: LcSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(3, (i) => _shimmerBar(context, i)),
          ),
        );
      },
    );
  }

  Widget _shimmerBar(BuildContext context, int index) {
    final width = index == 1 ? 0.6 : 1.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: LcSpacing.xs),
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth * width,
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: const [
                LcColors.shimmerBase,
                LcColors.shimmerHighlight,
                LcColors.shimmerBase,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
