import 'package:flutter/material.dart';
import '../tokens/lc_colors.dart';

/// LifeCircle OS — Color Scheme
///
/// Defines the Material 3 ColorScheme for Light, Dark, and
/// a stub for High Contrast (Phase 5 accessibility enhancement).
///
/// RULES:
/// - Never use LcColors directly in widgets. Use Theme.of(context).colorScheme.
/// - The theme is the single source of truth for all component colours.
abstract final class LcColorScheme {
  LcColorScheme._();

  // ──────────────────────────────────────────────────────────────
  // LIGHT THEME
  // ──────────────────────────────────────────────────────────────
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,

    // Primary — Deep Teal
    primary:          LcColors.brand700,
    onPrimary:        LcColors.white,
    primaryContainer: LcColors.brand100,
    onPrimaryContainer: LcColors.brand900,

    // Secondary — Warm Amber
    secondary:          LcColors.accent500,
    onSecondary:        LcColors.white,
    secondaryContainer: LcColors.accent100,
    onSecondaryContainer: LcColors.accent700,

    // Tertiary — Info Blue
    tertiary:          LcColors.info500,
    onTertiary:        LcColors.white,
    tertiaryContainer: LcColors.info100,
    onTertiaryContainer: LcColors.info700,

    // Error
    error:          LcColors.error500,
    onError:        LcColors.white,
    errorContainer: LcColors.error100,
    onErrorContainer: LcColors.error700,

    // Surface
    surface:     LcColors.white,
    onSurface:   LcColors.neutral900,
    surfaceContainerHighest: LcColors.neutral100,

    // Outline
    outline:        LcColors.neutral300,
    outlineVariant: LcColors.neutral200,

    // Scrim
    scrim: LcColors.scrim,
    shadow: LcColors.neutral900,
    inverseSurface: LcColors.neutral900,
    onInverseSurface: LcColors.neutral50,
    inversePrimary: LcColors.brand300,
  );

  // ──────────────────────────────────────────────────────────────
  // DARK THEME
  // ──────────────────────────────────────────────────────────────
  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,

    primary:          LcColors.brand400,
    onPrimary:        LcColors.brand900,
    primaryContainer: LcColors.brand800,
    onPrimaryContainer: LcColors.brand100,

    secondary:          LcColors.accent400,
    onSecondary:        LcColors.accent700,
    secondaryContainer: Color(0xFF4A2A0A),
    onSecondaryContainer: LcColors.accent100,

    tertiary:          LcColors.info500,
    onTertiary:        LcColors.white,
    tertiaryContainer: LcColors.info700,
    onTertiaryContainer: LcColors.info100,

    error:          LcColors.error500,
    onError:        LcColors.white,
    errorContainer: LcColors.error700,
    onErrorContainer: LcColors.error100,

    surface:     LcColors.neutral900,
    onSurface:   LcColors.neutral100,
    surfaceContainerHighest: LcColors.neutral800,

    outline:        LcColors.neutral600,
    outlineVariant: LcColors.neutral700,

    scrim: LcColors.scrim,
    shadow: LcColors.black,
    inverseSurface: LcColors.neutral100,
    onInverseSurface: LcColors.neutral900,
    inversePrimary: LcColors.brand700,
  );
}
