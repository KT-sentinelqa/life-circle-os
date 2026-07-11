// LifeCircle OS Design System — Motion
// Philosophy: Calm. Invisible. Purposeful.
// Animations must never feel jarring, punishing, or distracting.

import 'package:flutter/material.dart';

abstract class LCMotion {
  // ─────────────────────────────────────────────────────────
  // DURATIONS
  // Short for micro-feedback. Long for state transitions.
  // ─────────────────────────────────────────────────────────
  static const Duration microFeedback = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration gentle = Duration(milliseconds: 450);
  static const Duration slow = Duration(milliseconds: 600);

  // ─────────────────────────────────────────────────────────
  // CURVES
  // iOS-inspired spring feel. Decelerating for entrances,
  // accelerating for exits.
  // ─────────────────────────────────────────────────────────
  static const Curve enter = Curves.easeOutCubic; // Elements arriving
  static const Curve exit = Curves.easeInCubic; // Elements departing
  static const Curve spring =
      Curves.elasticOut; // Confirmations, peace score changes
  static const Curve linear = Curves.linear; // Progress indicators

  // ─────────────────────────────────────────────────────────
  // SEMANTIC TRANSITIONS
  // Name transitions by their human meaning, not their
  // technical implementation.
  // ─────────────────────────────────────────────────────────

  /// Used when a task is marked complete. Conveys calm resolution.
  static const Duration taskResolved = standard;
  static const Curve taskResolvedCurve = enter;

  /// Used when the Peace Index updates. Should feel like a breath.
  static const Duration peaceIndexUpdate = gentle;
  static const Curve peaceIndexCurve = spring;

  /// Used for page transitions. Never jarring.
  static const Duration pageTransition = standard;
  static const Curve pageTransitionCurve = enter;

  /// Used for exception alert appearing. Noticeable but not alarming.
  static const Duration alertAppear = fast;
  static const Curve alertAppearCurve = enter;
}
