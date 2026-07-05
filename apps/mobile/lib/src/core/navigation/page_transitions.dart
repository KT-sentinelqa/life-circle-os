import 'package:flutter/material.dart';

/// The global page transitions theme for LifeCircle OS.
class LifeCirclePageTransitionsTheme extends PageTransitionsTheme {
  /// Creates a [LifeCirclePageTransitionsTheme].
  const LifeCirclePageTransitionsTheme()
      : super(
          builders: const <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(),
            TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(),
            TargetPlatform.macOS: SharedAxisPageTransitionsBuilder(),
            TargetPlatform.windows: SharedAxisPageTransitionsBuilder(),
            TargetPlatform.linux: SharedAxisPageTransitionsBuilder(),
          },
        );
}

/// A standard shared axis transition builder for the entire app.
class SharedAxisPageTransitionsBuilder extends PageTransitionsBuilder {
  /// Creates a [SharedAxisPageTransitionsBuilder].
  const SharedAxisPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // Shared Axis (horizontal)
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
  }
}
