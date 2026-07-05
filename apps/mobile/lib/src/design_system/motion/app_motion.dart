import 'package:flutter/animation.dart';

/// Standard motion and animation tokens.
class AppMotion {
  /// Creates [AppMotion].
  const AppMotion._();

  /// Very fast interactions (e.g. button presses).
  static const Duration micro = Duration(milliseconds: 100);

  /// Fast interactions (e.g. staggered reveals).
  static const Duration fast = Duration(milliseconds: 150);

  /// Standard screen transitions and generic animations.
  static const Duration standard = Duration(milliseconds: 300);

  /// Slow animations (e.g. emphasizing a state change).
  static const Duration slow = Duration(milliseconds: 600);

  /// Pulse animations and ambient background effects.
  static const Duration pulse = Duration(milliseconds: 1200);

  /// Default animation curve.
  static const Curve defaultCurve = Curves.easeOutCubic;
}
