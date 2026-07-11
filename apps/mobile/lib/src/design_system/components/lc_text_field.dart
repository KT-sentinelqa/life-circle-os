import 'package:flutter/material.dart';
import '../tokens/lc_spacing.dart';
import '../tokens/lc_radii.dart';
import '../tokens/lc_animation.dart';

/// LcTextField — LifeCircle Design System
///
/// The standard input field for all forms in LifeCircle.
/// Wraps Flutter's TextField with design-system styles and
/// mandatory accessibility semantics.
///
/// RULES:
/// - Always provide a [label] for screen reader support.
/// - [hintText] is optional — never use it as a substitute for [label].
/// - Error messages must be actionable (UX Constitution Law 4).
class LcTextField extends StatelessWidget {
  const LcTextField({
    required this.label,
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.helperText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.autofocus = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autofocus;
  final bool enabled;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      textField: true,
      enabled: enabled,
      child: AnimatedContainer(
        duration: LcAnimation.standard,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          autofocus: autofocus,
          enabled: enabled,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            errorText: errorText,
            helperText: helperText,
            helperMaxLines: 3, // Allow actionable error messages to wrap
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
