import 'package:flutter/animation.dart';

/// Standardized animation durations and curves for LifeCircle OS.
class AppMotion {
  const AppMotion._();

  /// Fast animation duration (150ms). Best for micro-interactions.
  static const Duration fast = Duration(milliseconds: 150);
  
  /// Normal animation duration (250ms). Best for standard transitions.
  static const Duration normal = Duration(milliseconds: 250);
  
  /// Slow animation duration (350ms). Best for large screen transitions.
  static const Duration slow = Duration(milliseconds: 350);

  /// Standard easing curve.
  static const Curve standard = Curves.easeInOutCubic;
  
  /// Decelerate curve (fast out, slow in).
  static const Curve decelerate = Curves.easeOutCubic;
  
  /// Accelerate curve (slow out, fast in).
  static const Curve accelerate = Curves.easeInCubic;
}
