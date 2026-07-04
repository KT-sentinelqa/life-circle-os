import 'package:flutter/material.dart';

import '../radius/app_radius.dart';
import '../spacing/app_spacing.dart';

/// A standardized button for LifeCircle OS following the design tokens.
class LcButton extends StatelessWidget {
  /// Creates an [LcButton].
  const LcButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  /// The text to display inside the button.
  final String text;

  /// The callback that is called when the button is tapped.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.md,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
