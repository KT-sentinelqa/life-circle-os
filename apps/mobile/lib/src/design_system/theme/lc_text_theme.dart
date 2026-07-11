import 'package:flutter/material.dart';
import '../tokens/lc_typography.dart';
import '../tokens/lc_colors.dart';

/// LifeCircle OS — Text Theme
///
/// Maps LcTypography tokens to the Material 3 TextTheme.
/// Apply to both light and dark ThemeData via [LcTextTheme.build].
abstract final class LcTextTheme {
  LcTextTheme._();

  static TextTheme build({required Brightness brightness}) {
    final contentColor = brightness == Brightness.light
        ? LcColors.neutral900
        : LcColors.neutral100;

    final subtleColor = brightness == Brightness.light
        ? LcColors.neutral600
        : LcColors.neutral400;

    return TextTheme(
      displayLarge:  LcTypography.displayLarge.copyWith(color: contentColor),
      displayMedium: LcTypography.displayMedium.copyWith(color: contentColor),
      displaySmall:  LcTypography.displaySmall.copyWith(color: contentColor),

      headlineLarge:  LcTypography.headlineLarge.copyWith(color: contentColor),
      headlineMedium: LcTypography.headlineMedium.copyWith(color: contentColor),
      headlineSmall:  LcTypography.headlineSmall.copyWith(color: contentColor),

      titleLarge:  LcTypography.titleLarge.copyWith(color: contentColor),
      titleMedium: LcTypography.titleMedium.copyWith(color: contentColor),
      titleSmall:  LcTypography.titleSmall.copyWith(color: subtleColor),

      bodyLarge:  LcTypography.bodyLarge.copyWith(color: contentColor),
      bodyMedium: LcTypography.bodyMedium.copyWith(color: contentColor),
      bodySmall:  LcTypography.bodySmall.copyWith(color: subtleColor),

      labelLarge:  LcTypography.labelLarge.copyWith(color: contentColor),
      labelMedium: LcTypography.labelMedium.copyWith(color: subtleColor),
      labelSmall:  LcTypography.labelSmall.copyWith(color: subtleColor),
    );
  }
}
