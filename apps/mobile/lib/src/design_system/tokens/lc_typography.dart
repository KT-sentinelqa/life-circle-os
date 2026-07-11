import 'package:flutter/material.dart';
import 'lc_colors.dart';

/// LifeCircle OS — Typography Token System
///
/// Font families:
///   Display: DM Serif Display (warm, expressive, human)
///   Body:    DM Sans (clean, modern, highly legible)
///
/// Add to pubspec.yaml:
///   google_fonts: ^6.1.0
///
/// RULES:
/// - Minimum body: 14sp. Minimum label: 12sp.
/// - Never override fontFamily inline. Always use these tokens.
/// - Dynamic text scaling is supported by default (no textScaleFactor clamps).
abstract final class LcTypography {
  LcTypography._();

  static const String _displayFamily = 'DM Serif Display';
  static const String _bodyFamily    = 'DM Sans';

  // ──────────────────────────────────────────────────────────────
  // DISPLAY — Expressive hero text (onboarding, section headers)
  // ──────────────────────────────────────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _displayFamily,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _displayFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.5,
    height: 1.15,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: _displayFamily,
    fontSize: 28,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

  // ──────────────────────────────────────────────────────────────
  // HEADLINE — Section-level titles
  // ──────────────────────────────────────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // ──────────────────────────────────────────────────────────────
  // TITLE — Card titles, list headers
  // ──────────────────────────────────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // ──────────────────────────────────────────────────────────────
  // BODY — Primary reading content
  // ──────────────────────────────────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.55,
    letterSpacing: 0.15,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 14, // Minimum body size
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.25,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 12, // Minimum label size
    fontWeight: FontWeight.w400,
    height: 1.45,
    letterSpacing: 0.4,
  );

  // ──────────────────────────────────────────────────────────────
  // LABEL — Buttons, chips, badges, form inputs
  // ──────────────────────────────────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: _bodyFamily,
    fontSize: 12, // Minimum label size
    fontWeight: FontWeight.w500,
    height: 1.35,
    letterSpacing: 0.5,
  );

  // ──────────────────────────────────────────────────────────────
  // MONO — Dates, IDs, reference numbers
  // ──────────────────────────────────────────────────────────────
  static const TextStyle mono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  // Helper: apply a foreground colour to any token
  static TextStyle colored(TextStyle style, Color color) =>
      style.copyWith(color: color);
}
