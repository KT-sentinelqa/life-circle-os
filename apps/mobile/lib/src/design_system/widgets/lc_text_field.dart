import 'package:flutter/material.dart';

/// Standard text field for the LifeCircle app.
class LcTextField extends StatelessWidget {
  /// Creates an [LcTextField].
  const LcTextField({
    required this.label,
    this.controller,
    this.obscureText = false,
    super.key,
  });
  
  /// The label for the text field.
  final String label;
  /// Optional controller.
  final TextEditingController? controller;
  /// Whether the text should be obscured (e.g., passwords).
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(labelText: label),
    );
  }
}
