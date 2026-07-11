/// LifeCircle OS — Border Radius Token System
///
/// Consistent radii reinforce the LifeCircle visual identity:
/// soft and approachable, never sharp or clinical.
///
/// RULES:
/// - Never hardcode BorderRadius values inline.
/// - Always use LcRadii tokens.
import 'package:flutter/material.dart';

abstract final class LcRadii {
  LcRadii._();

  /// 4dp — subtle rounding on dense elements (chips, small badges)
  static const double xs  = 4;

  /// 8dp — standard element rounding (inputs, small cards)
  static const double sm  = 8;

  /// 12dp — medium cards, bottom sheets inner elements
  static const double md  = 12;

  /// 16dp — standard cards
  static const double lg  = 16;

  /// 20dp — prominent cards, drawers
  static const double xl  = 20;

  /// 24dp — bottom sheets, modal sheets
  static const double xl2 = 24;

  /// 32dp — large modals, onboarding surfaces
  static const double xl3 = 32;

  /// 100dp — pill-shaped buttons, chips, avatars
  static const double full = 100;

  // ──────────────────────────────────────────────────────────────
  // SEMANTIC ALIASES
  // ──────────────────────────────────────────────────────────────

  static BorderRadius get cardRadius =>
      BorderRadius.circular(lg);

  static BorderRadius get buttonRadius =>
      BorderRadius.circular(full);

  static BorderRadius get chipRadius =>
      BorderRadius.circular(full);

  static BorderRadius get inputRadius =>
      BorderRadius.circular(sm);

  static BorderRadius get bottomSheetRadius => const BorderRadius.vertical(
    top: Radius.circular(xl2),
  );

  static BorderRadius get dialogRadius =>
      BorderRadius.circular(xl2);

  static BorderRadius get avatarRadius =>
      BorderRadius.circular(full);
}
