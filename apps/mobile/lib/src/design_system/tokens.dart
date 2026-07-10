// LifeCircle OS Design System — Tokens
// Version: 1.0
// These values are the single source of truth for all UI decisions.
// No widget may define color, spacing, or typography outside of this file.

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────
// PALETTE
// Named semantically, not by hex value.
// ─────────────────────────────────────────────────────────────
abstract class LCColors {
  // Core Brand
  static const Color peacefulTeal = Color(0xFF1A9E96);       // Primary CTA
  static const Color trustNavy    = Color(0xFF0D2B45);       // Headers, primary text (dark)
  static const Color calmSky      = Color(0xFFE8F7F6);       // Backgrounds, soft surfaces

  // Semantic States
  static const Color confidenceGreen = Color(0xFF34A853);    // Peace Score: High
  static const Color watchAmber      = Color(0xFFF9A825);    // Peace Score: Medium
  static const Color escalationRose  = Color(0xFFEF5350);    // Exception Alert / Danger

  // Neutrals
  static const Color inkPrimary   = Color(0xFF1C1C1E);       // Body text (light mode)
  static const Color inkSecondary = Color(0xFF6D6D72);       // Labels, captions
  static const Color inkDisabled  = Color(0xFFAEAEB2);       // Disabled states
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceF2    = Color(0xFFF2F2F7);       // List backgrounds
  static const Color borderSubtle = Color(0xFFE5E5EA);

  // Dark Mode Equivalents
  static const Color darkBackground = Color(0xFF0A0A0F);
  static const Color darkSurface    = Color(0xFF1C1C1E);
  static const Color darkSurface2   = Color(0xFF2C2C2E);
  static const Color darkBorder     = Color(0xFF3A3A3C);
  static const Color darkInkPrimary = Color(0xFFF2F2F7);
}

// ─────────────────────────────────────────────────────────────
// SPACING
// Based on a 4pt grid. Only multiples of 4 are valid.
// ─────────────────────────────────────────────────────────────
abstract class LCSpacing {
  static const double xs  =  4.0;
  static const double sm  =  8.0;
  static const double md  = 16.0;
  static const double lg  = 24.0;
  static const double xl  = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

// ─────────────────────────────────────────────────────────────
// TYPOGRAPHY
// Using the system font (SF Pro / Roboto) scaled for calm readability.
// ─────────────────────────────────────────────────────────────
abstract class LCTextStyles {
  static const String fontFamily = 'SF Pro Display'; // iOS; Roboto fallback on Android

  static const TextStyle displayLarge = TextStyle(
    fontSize: 48, fontWeight: FontWeight.w700, height: 1.1, letterSpacing: -1.5,
  );
  static const TextStyle displayMedium = TextStyle(
    fontSize: 36, fontWeight: FontWeight.w700, height: 1.2, letterSpacing: -1.0,
  );
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 28, fontWeight: FontWeight.w600, height: 1.3, letterSpacing: -0.5,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w600, height: 1.3,
  );
  static const TextStyle titleMedium = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w600, height: 1.4,
  );
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 17, fontWeight: FontWeight.w400, height: 1.5,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, height: 1.5,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, height: 1.4, letterSpacing: 0.1,
  );
  static const TextStyle label = TextStyle(
    fontSize: 11, fontWeight: FontWeight.w500, height: 1.2, letterSpacing: 0.5,
  );
}

// ─────────────────────────────────────────────────────────────
// BORDER RADII
// ─────────────────────────────────────────────────────────────
abstract class LCRadius {
  static const double sm  =  8.0;
  static const double md  = 12.0;
  static const double lg  = 16.0;
  static const double xl  = 24.0;
  static const double full = 999.0; // For pill shapes
}

// ─────────────────────────────────────────────────────────────
// ELEVATION & SHADOW
// ─────────────────────────────────────────────────────────────
abstract class LCShadows {
  static const List<BoxShadow> cardSubtle = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2)),
  ];
  static const List<BoxShadow> cardLifted = [
    BoxShadow(color: Color(0x1A000000), blurRadius: 20, offset: Offset(0, 8)),
  ];
}
