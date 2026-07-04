import 'package:flutter/material.dart';

class LcTextField extends StatelessWidget {
  const LcTextField({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
  });
  
  final String label;
  final TextEditingController? controller;
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
