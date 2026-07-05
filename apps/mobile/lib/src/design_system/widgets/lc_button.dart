import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifecircle_mobile/src/design_system/motion/app_motion.dart';

/// Standard button for the LifeCircle app.
class LcButton extends StatefulWidget {
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
  State<LcButton> createState() => _LcButtonState();
}

class _LcButtonState extends State<LcButton> {
  bool _isPressed = false;

  void _handleTapDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(PointerUpEvent event) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel(PointerCancelEvent event) {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _handleTapDown,
      onPointerUp: _handleTapUp,
      onPointerCancel: _handleTapCancel,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: AppMotion.micro,
        curve: AppMotion.defaultCurve,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 48,
            minHeight: 48,
          ),
          child: ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              widget.onPressed();
            },
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}
