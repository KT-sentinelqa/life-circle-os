import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/motion/app_motion.dart';

/// A custom page that provides a horizontal shared axis transition.
class SharedAxisPageRoute<T> extends CustomTransitionPage<T> {
  /// Creates a [SharedAxisPageRoute].
  SharedAxisPageRoute({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideIn = Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            );

            final fadeIn = Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            );

            final slideOut = Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-0.05, 0),
            ).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeOutCubic,
              ),
            );

            final fadeOut = Tween<double>(begin: 1, end: 0).animate(
              CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeOutCubic,
              ),
            );

            return SlideTransition(
              position: slideOut,
              child: FadeTransition(
                opacity: fadeOut,
                child: SlideTransition(
                  position: slideIn,
                  child: FadeTransition(
                    opacity: fadeIn,
                    child: child,
                  ),
                ),
              ),
            );
          },
          transitionDuration: AppMotion.standard,
          reverseTransitionDuration: AppMotion.standard,
        );
}
