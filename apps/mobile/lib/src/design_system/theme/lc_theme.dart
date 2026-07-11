import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../tokens/lc_radii.dart';
import '../tokens/lc_animation.dart';
import '../tokens/lc_spacing.dart';
import 'lc_color_scheme.dart';
import 'lc_text_theme.dart';

/// LifeCircle OS — Theme Engine
///
/// The single source of truth for all ThemeData.
/// Usage in MaterialApp:
///
///   MaterialApp(
///     theme:      LcTheme.light,
///     darkTheme:  LcTheme.dark,
///     themeMode:  ThemeMode.system,
///   )
abstract final class LcTheme {
  LcTheme._();

  static ThemeData get light => _build(LcColorScheme.light);
  static ThemeData get dark  => _build(LcColorScheme.dark);

  static ThemeData _build(ColorScheme colorScheme) {
    final isLight = colorScheme.brightness == Brightness.light;

    final textTheme = LcTextTheme.build(brightness: colorScheme.brightness);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,

      // ── AppBar ─────────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        systemOverlayStyle: isLight
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge,
      ),

      // ── Cards ──────────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: LcElevation.card,
        shape: RoundedRectangleBorder(borderRadius: LcRadii.cardRadius),
        surfaceTintColor: colorScheme.primary,
        clipBehavior: Clip.antiAlias,
      ),

      // ── Buttons ────────────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(88, LcSpacing.touchTarget),
          shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
          textStyle: textTheme.labelLarge,
          animationDuration: LcAnimation.fast,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(88, LcSpacing.touchTarget),
          shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(88, LcSpacing.touchTarget),
          shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, LcSpacing.touchTarget),
          shape: RoundedRectangleBorder(borderRadius: LcRadii.buttonRadius),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── Input Fields ───────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight
            ? colorScheme.surfaceContainerHighest
            : colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: LcRadii.inputRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: LcRadii.inputRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: LcRadii.inputRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LcSpacing.md,
          vertical: LcSpacing.sm,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.45),
        ),
      ),

      // ── Bottom Navigation ──────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        elevation: LcElevation.nav,
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.all(textTheme.labelMedium),
      ),

      // ── Dialogs ────────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: LcRadii.dialogRadius),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),

      // ── Bottom Sheets ──────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(LcRadii.xl2)),
        ),
        showDragHandle: true,
        clipBehavior: Clip.antiAlias,
      ),

      // ── List Tiles ─────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        minVerticalPadding: LcSpacing.sm,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: LcSpacing.md,
          vertical: LcSpacing.xs2,
        ),
        titleTextStyle: textTheme.titleMedium,
        subtitleTextStyle: textTheme.bodySmall,
      ),

      // ── Divider ────────────────────────────────────────────────
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      // ── Page Transitions ───────────────────────────────────────
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS:     CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        },
      ),
    );
  }
}

// Export the elevation tokens from lc_animation.dart here for convenience
export '../tokens/lc_animation.dart' show LcElevation;
