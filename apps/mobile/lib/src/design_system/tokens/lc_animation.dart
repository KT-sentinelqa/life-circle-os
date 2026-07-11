/// LifeCircle OS — Animation Token System
///
/// Motion reinforces understanding, not decoration.
/// Every animation in LifeCircle uses these defined durations and curves.
///
/// UX Constitution Law 10: Animations must communicate state change
/// or spatial relationships. Never animate purely for decoration.
import 'package:flutter/material.dart';

abstract final class LcAnimation {
  LcAnimation._();

  // ──────────────────────────────────────────────────────────────
  // DURATIONS
  // ──────────────────────────────────────────────────────────────

  /// 100ms — micro-interactions (tap feedback, icon transitions)
  static const Duration micro    = Duration(milliseconds: 100);

  /// 150ms — fast state changes (toggle, checkbox)
  static const Duration fast     = Duration(milliseconds: 150);

  /// 200ms — standard transitions (button states, expansion)
  static const Duration standard = Duration(milliseconds: 200);

  /// 300ms — page-level transitions, modals appearing
  static const Duration medium   = Duration(milliseconds: 300);

  /// 400ms — complex state changes (loading → content reveal)
  static const Duration slow     = Duration(milliseconds: 400);

  /// 600ms — onboarding / hero animations only
  static const Duration expressive = Duration(milliseconds: 600);

  // ──────────────────────────────────────────────────────────────
  // CURVES
  // ──────────────────────────────────────────────────────────────

  /// Standard ease for most transitions — Material 3 standard easing
  static const Curve standard_ = Curves.easeInOutCubic;

  /// Emphasis ease — for elements entering the screen
  static const Curve enter     = Curves.easeOutCubic;

  /// Deceleration — for elements leaving the screen
  static const Curve exit      = Curves.easeInCubic;

  /// Overshoot — for playful success states only
  static const Curve overshoot = Curves.elasticOut;

  /// Linear — reserved for continuous animations (sync pulse, shimmer)
  static const Curve linear    = Curves.linear;

  // ──────────────────────────────────────────────────────────────
  // SEMANTIC ALIASES
  // ──────────────────────────────────────────────────────────────

  /// Page route transition specification
  static const Duration pageTransitionDuration = medium;
  static const Curve    pageTransitionCurve    = enter;

  /// Bottom sheet appear / dismiss
  static const Duration sheetDuration = medium;
  static const Curve    sheetCurve    = enter;

  /// Shimmer skeleton animation
  static const Duration shimmerDuration = Duration(milliseconds: 1200);

  /// Sync pulse animation
  static const Duration syncPulseDuration = Duration(milliseconds: 900);
}

/// Elevation tokens — Surface shadow levels aligned to Material 3.
abstract final class LcElevation {
  LcElevation._();

  /// 0dp — flat surfaces (backgrounds, default cards in dark mode)
  static const double flat     = 0;

  /// 1dp — standard card elevation
  static const double card     = 1;

  /// 2dp — raised cards, pressed surfaces
  static const double raised   = 2;

  /// 4dp — app bar, navigation bar
  static const double nav      = 4;

  /// 6dp — floating action buttons, chips
  static const double floating = 6;

  /// 8dp — menus, dropdowns
  static const double menu     = 8;

  /// 12dp — bottom sheets (start of overlay layer)
  static const double overlay  = 12;

  /// 16dp — dialogs, modals
  static const double dialog   = 16;

  /// 24dp — top-level modals
  static const double modal    = 24;
}
