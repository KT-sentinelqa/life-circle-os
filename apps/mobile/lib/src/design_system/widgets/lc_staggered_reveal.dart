import 'package:flutter/material.dart';

/// A widget that reveals its child with a staggered fade and slide animation.
class LcStaggeredReveal extends StatefulWidget {
  /// Creates an [LcStaggeredReveal].
  const LcStaggeredReveal({
    required this.child,
    required this.index,
    this.staggerDelay = const Duration(milliseconds: 80),
    super.key,
  });

  /// The widget to reveal.
  final Widget child;

  /// The index of this item in the sequence (0-based).
  final int index;

  /// The delay per index.
  final Duration staggerDelay;

  @override
  State<LcStaggeredReveal> createState() => _LcStaggeredRevealState();
}

class _LcStaggeredRevealState extends State<LcStaggeredReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(widget.staggerDelay * widget.index, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
