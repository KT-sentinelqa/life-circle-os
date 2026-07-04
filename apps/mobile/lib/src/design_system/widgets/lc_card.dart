import 'package:flutter/material.dart';

import 'package:mobile/src/design_system/elevation/app_elevation.dart';
import 'package:mobile/src/design_system/radius/app_radius.dart';
import 'package:mobile/src/design_system/spacing/app_spacing.dart';

/// A standardized card for LifeCircle OS following the design tokens.
class LcCard extends StatelessWidget {
  /// Creates an [LcCard].
  const LcCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The padding to apply inside the card.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevation.level1,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.md,
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
