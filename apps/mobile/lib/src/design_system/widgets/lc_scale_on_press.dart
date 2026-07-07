import 'package:flutter/material.dart';

/// A wrapper widget that animates a scale down effect when pressed.
class LcScaleOnPress extends StatefulWidget {
  /// Creates an [LcScaleOnPress].
  const LcScaleOnPress({
    required this.child,
    this.onTap,
    this.scaleFactor = 0.96,
    super.key,
  });

  /// The child widget to scale.
  final Widget child;

  /// Callback when the widget is tapped.
  final VoidCallback? onTap;

  /// How much to scale down (default 0.96).
  final double scaleFactor;

  @override
  State<LcScaleOnPress> createState() => _LcScaleOnPressState();
}

class _LcScaleOnPressState extends State<LcScaleOnPress> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _isPressed ? widget.scaleFactor : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
