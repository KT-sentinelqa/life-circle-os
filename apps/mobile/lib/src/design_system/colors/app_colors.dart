import 'package:flutter/material.dart';

/// Semantic color palette for LifeCircle OS.
///
/// Strictly enforces the Deep Teal and Warm Gold branding
/// with WCAG AA compliant contrast ratios.
class AppColors {
  const AppColors._();

  // --- Primary Palette: Deep Teal ---
  /// Deep Teal (Primary). Used for primary buttons and active states.
  static const Color primary = Color(0xFF006D77);

  /// Light Teal (Primary Variant). Used for subtle highlights.
  static const Color primaryLight = Color(0xFF83C5BE);

  /// Dark Teal (Primary Variant). Used for deep backgrounds or
  /// high-contrast text.
  static const Color primaryDark = Color(0xFF004D54);

  // --- Accent Palette: Warm Gold ---
  /// Warm Gold (Secondary). Used for floating action buttons and emphasis.
  static const Color secondary = Color(0xFFFFDDD2);

  /// Deep Gold (Secondary Variant). Used for secondary contrast.
  static const Color secondaryDark = Color(0xFFE29578);

  // --- Semantic & Status Colors ---
  /// Error color for validation and destructive actions.
  static const Color error = Color(0xFFBA1A1A);

  /// Success color for confirmations.
  static const Color success = Color(0xFF2E7D32);

  /// Warning color for alerts.
  static const Color warning = Color(0xFFED6C02);

  // --- Surface & Background (Light) ---
  /// Standard light background.
  static const Color backgroundLight = Color(0xFFF8F9FA);

  /// Elevated surface color (cards, dialogs) in light mode.
  static const Color surfaceLight = Color(0xFFFFFFFF);

  /// Primary text color in light mode.
  static const Color textPrimaryLight = Color(0xFF1E1E1E);

  /// Secondary text color in light mode.
  static const Color textSecondaryLight = Color(0xFF757575);

  // --- Surface & Background (Dark) ---
  /// Standard dark background.
  static const Color backgroundDark = Color(0xFF121212);

  /// Elevated surface color in dark mode.
  static const Color surfaceDark = Color(0xFF1E1E1E);

  /// Primary text color in dark mode.
  static const Color textPrimaryDark = Color(0xFFE0E0E0);

  /// Secondary text color in dark mode.
  static const Color textSecondaryDark = Color(0xFFAAAAAA);
}
