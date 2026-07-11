import 'package:flutter/material.dart';
import '../tokens/lc_spacing.dart';
import '../tokens/lc_radii.dart';
import '../tokens/lc_animation.dart';
import '../tokens/lc_typography.dart';

/// LcCard — LifeCircle Design System
///
/// The base card primitive. Use for any bounded content container.
///
/// Variants:
///   - [LcCard.flat]       — flat, no elevation (default for lists)
///   - [LcCard.elevated]   — standard elevation card
///   - [LcCard.outlined]   — bordered, no shadow
///   - [LcCard.interactive] — tappable with ripple
class LcCard extends StatelessWidget {
  const LcCard({
    required this.child,
    super.key,
    this.padding  = const EdgeInsets.all(LcSpacing.md),
    this.margin   = EdgeInsets.zero,
    this.elevation = 1,
    this.onTap,
    this.semanticsLabel,
  });

  const LcCard.flat({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(LcSpacing.md),
    this.margin  = EdgeInsets.zero,
    this.onTap,
    this.semanticsLabel,
  }) : elevation = 0;

  const LcCard.elevated({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(LcSpacing.md),
    this.margin  = EdgeInsets.zero,
    this.onTap,
    this.semanticsLabel,
  }) : elevation = 2;

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final VoidCallback? onTap;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: semanticsLabel,
      container: semanticsLabel != null,
      child: Card(
        elevation: elevation,
        margin: margin,
        shape: RoundedRectangleBorder(borderRadius: LcRadii.cardRadius),
        clipBehavior: Clip.antiAlias,
        child: onTap != null
            ? InkWell(
                onTap: onTap,
                borderRadius: LcRadii.cardRadius,
                child: Padding(padding: padding, child: child),
              )
            : Padding(padding: padding, child: child),
      ),
    );
  }
}
