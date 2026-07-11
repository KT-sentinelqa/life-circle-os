import 'package:flutter/material.dart';
import '../tokens/lc_spacing.dart';
import '../tokens/lc_radii.dart';
import '../tokens/lc_animation.dart';
import '../tokens/lc_typography.dart';

/// LcButton — LifeCircle Design System
///
/// Three visual variants: primary (filled), secondary (outlined), ghost (text).
/// All variants enforce the 48dp minimum touch target (UX Constitution Law 8).
/// Semantics and accessibility labels are always required.
enum LcButtonVariant { primary, secondary, ghost }

class LcButton extends StatelessWidget {
  const LcButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant   = LcButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.semanticsLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final LcButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final child = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: variant == LcButtonVariant.primary
                  ? colorScheme.onPrimary
                  : colorScheme.primary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: LcSpacing.xs),
              ],
              Text(label),
            ],
          );

    final buttonChild = Semantics(
      label: semanticsLabel ?? label,
      button: true,
      child: child,
    );

    Widget button;

    switch (variant) {
      case LcButtonVariant.primary:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            minimumSize: const Size(88, LcSpacing.touchTarget),
            shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
            animationDuration: LcAnimation.fast,
          ),
          child: buttonChild,
        );
      case LcButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(88, LcSpacing.touchTarget),
            shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
          ),
          child: buttonChild,
        );
      case LcButtonVariant.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            minimumSize: const Size(48, LcSpacing.touchTarget),
            shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
          ),
          child: buttonChild,
        );
    }

    return isFullWidth
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
