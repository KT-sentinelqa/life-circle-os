import 'package:flutter/material.dart';

/// Standard button for the LifeCircle app.
class LcButton extends StatelessWidget {
  /// Creates an [LcButton].
  const LcButton({
    required this.text,
    required this.onPressed,
    super.key,
  });
  
  /// Button text.
  final String text;
  /// Callback when pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
