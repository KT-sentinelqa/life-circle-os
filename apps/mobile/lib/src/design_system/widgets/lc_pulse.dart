import 'dart:async';
import 'package:flutter/material.dart';

/// A widget that periodically scales its child to create a subtle pulsing effect.
class LcPulse extends StatefulWidget {
  /// Creates an [LcPulse].
  const LcPulse({
    required this.child,
    this.scale = 1.02,
    this.duration = const Duration(milliseconds: 1200),
    this.interval = const Duration(seconds: 6),
    super.key,
  });

  /// The child widget to pulse.
  final Widget child;

  /// The peak scale value.
  final double scale;

  /// The duration of a single pulse.
  final Duration duration;

  /// The interval between the start of each pulse.
  final Duration interval;

  @override
  State<LcPulse> createState() => _LcPulseState();
}

class _LcPulseState extends State<LcPulse>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: widget.scale)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: widget.scale, end: 1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(_controller);

    _timer = Timer.periodic(widget.interval, (_) {
      if (mounted) {
        _controller.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
