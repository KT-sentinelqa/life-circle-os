import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/design_system/motion/app_motion.dart';

/// An animated switcher that implements the horizontal shared axis transition.
class LcSharedAxisSwitcher extends StatelessWidget {
  /// Creates an [LcSharedAxisSwitcher].
  const LcSharedAxisSwitcher({
    required this.child,
    this.reverse = false,
    super.key,
  });

  /// The current child widget. Must have a unique key.
  final Widget child;

  /// Whether the animation should play in reverse (e.g. going back a step).
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppMotion.standard,
      reverseDuration: AppMotion.standard,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (childWidget, animation) {
        final isIncoming = childWidget.key == child.key;
        final sign = reverse ? -1.0 : 1.0;

        // Incoming animation goes 0.0 -> 1.0.
        // Outgoing animation goes 1.0 -> 0.0, so it plays in reverse.
        final slideTween = isIncoming
            ? Tween<Offset>(begin: Offset(0.05 * sign, 0), end: Offset.zero)
            : Tween<Offset>(begin: Offset(-0.05 * sign, 0), end: Offset.zero);

        final offsetAnimation = slideTween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        final fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}
