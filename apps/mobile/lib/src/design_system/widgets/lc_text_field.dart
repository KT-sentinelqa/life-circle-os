import 'package:flutter/material.dart';

/// Standard text field for the LifeCircle app.
class LcTextField extends StatelessWidget {
  /// Creates an [LcTextField].
  const LcTextField({
    required this.label,
    this.controller,
    this.validator,
    this.obscureText = false,
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

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(labelText: label),
    );
  }
}
