import 'package:flutter/material.dart';

import 'package:mobile/src/design_system/radius/app_radius.dart';
import 'package:mobile/src/design_system/spacing/app_spacing.dart';

/// A standardized text field for LifeCircle OS following the design tokens.
class LcTextField extends StatelessWidget {
  /// Creates an [LcTextField].
  const LcTextField({
    required this.label,
    this.controller,
    this.obscureText = false,
    super.key,
  });

  /// The label text to display above or inside the field.
  final String label;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: AppRadius.md,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),
    );
  }
}
