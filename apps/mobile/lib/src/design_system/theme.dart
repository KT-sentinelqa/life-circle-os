// LifeCircle OS Design System — Theme
// Single source of truth for Flutter ThemeData.
// Both light and dark modes must be explicitly defined here.

import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/design_system/tokens.dart';

class LCTheme {
  LCTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: LCColors.surfaceF2,
        colorScheme: const ColorScheme.light(
          primary: LCColors.peacefulTeal,
          secondary: LCColors.trustNavy,
          onSecondary: LCColors.surfaceWhite,
          error: LCColors.escalationRose,
          onSurface: LCColors.inkPrimary,
        ),
        textTheme: _textTheme(LCColors.inkPrimary, LCColors.inkSecondary),
        cardTheme: CardThemeData(
          elevation: 0,
          color: LCColors.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LCRadius.lg),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: LCColors.surfaceF2,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: LCColors.inkPrimary,
          ),
          iconTheme: IconThemeData(color: LCColors.peacefulTeal),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: LCColors.peacefulTeal,
            foregroundColor: LCColors.surfaceWhite,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LCRadius.md),
            ),
            textStyle: LCTextStyles.titleMedium,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: LCColors.borderSubtle,
          thickness: 0.5,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: LCColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: LCColors.peacefulTeal,
          onPrimary: LCColors.surfaceWhite,
          secondary: LCColors.calmSky,
          onSecondary: LCColors.trustNavy,
          error: LCColors.escalationRose,
          surface: LCColors.darkSurface,
          onSurface: LCColors.darkInkPrimary,
        ),
        textTheme: _textTheme(LCColors.darkInkPrimary, LCColors.inkDisabled),
        cardTheme: CardThemeData(
          elevation: 0,
          color: LCColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(LCRadius.lg),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: LCColors.darkBackground,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: LCColors.darkInkPrimary,
          ),
          iconTheme: IconThemeData(color: LCColors.peacefulTeal),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: LCColors.peacefulTeal,
            foregroundColor: LCColors.surfaceWhite,
            minimumSize: const Size(double.infinity, 54),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LCRadius.md),
            ),
            textStyle: LCTextStyles.titleMedium,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: LCColors.darkBorder,
          thickness: 0.5,
        ),
      );

  static TextTheme _textTheme(Color primary, Color secondary) => TextTheme(
        displayLarge: LCTextStyles.displayLarge.copyWith(color: primary),
        displayMedium: LCTextStyles.displayMedium.copyWith(color: primary),
        headlineLarge: LCTextStyles.headlineLarge.copyWith(color: primary),
        headlineMedium: LCTextStyles.headlineMedium.copyWith(color: primary),
        titleMedium: LCTextStyles.titleMedium.copyWith(color: primary),
        bodyLarge: LCTextStyles.bodyLarge.copyWith(color: primary),
        bodyMedium: LCTextStyles.bodyMedium.copyWith(color: secondary),
        labelSmall: LCTextStyles.label.copyWith(color: secondary),
      );
}
