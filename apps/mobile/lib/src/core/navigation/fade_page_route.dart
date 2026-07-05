import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/motion/app_motion.dart';

/// A custom page that provides a simple fade transition.
class FadePageRoute<T> extends CustomTransitionPage<T> {
  /// Creates a [FadePageRoute].
  FadePageRoute({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeOutCubic).animate(animation),
              child: child,
            );
          },
          transitionDuration: AppMotion.standard,
          reverseTransitionDuration: AppMotion.standard,
        );
}
