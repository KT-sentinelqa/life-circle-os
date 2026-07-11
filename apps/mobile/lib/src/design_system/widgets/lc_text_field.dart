import 'package:flutter/material.dart';

/// Standard text field for the LifeCircle app.
class LcTextField extends StatelessWidget {
  /// Creates an [LcTextField].
  const LcTextField({
    required this.label,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.autofocus = false,
    super.key,
  });

  /// The label for the text field.
  final String label;

  /// Optional controller.
  final TextEditingController? controller;

  /// Optional validator for form fields.
  final String? Function(String?)? validator;

  /// Whether the text should be obscured (e.g., passwords).
  final bool obscureText;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      autofocus: autofocus,
      decoration: InputDecoration(labelText: label),
    );
  }
}
