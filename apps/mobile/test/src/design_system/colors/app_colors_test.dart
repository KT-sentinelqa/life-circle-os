import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/colors/app_colors.dart';

void main() {
  group('AppColors WCAG AA Compliance Tests', () {
    double calculateRelativeLuminance(Color color) {
      double processChannel(int channel) {
        final c = channel / 255.0;
        return c <= 0.03928 ? c / 12.92 : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
      }

      final r = processChannel(color.red);
      final g = processChannel(color.green);
      final b = processChannel(color.blue);

      return 0.2126 * r + 0.7152 * g + 0.0722 * b;
    }

    double calculateContrastRatio(Color color1, Color color2) {
      final l1 = calculateRelativeLuminance(color1);
      final l2 = calculateRelativeLuminance(color2);

      final lightest = l1 > l2 ? l1 : l2;
      final darkest = l1 > l2 ? l2 : l1;

      return (lightest + 0.05) / (darkest + 0.05);
    }

    test('Primary color vs White text contrast should be >= 4.5', () {
      final contrast = calculateContrastRatio(AppColors.primary, Colors.white);
      expect(contrast, greaterThanOrEqualTo(4.5));
    });

    test('SurfaceLight vs TextPrimaryLight contrast should be >= 4.5', () {
      final contrast = calculateContrastRatio(AppColors.surfaceLight, AppColors.textPrimaryLight);
      expect(contrast, greaterThanOrEqualTo(4.5));
    });

    test('BackgroundDark vs TextPrimaryDark contrast should be >= 4.5', () {
      final contrast = calculateContrastRatio(AppColors.backgroundDark, AppColors.textPrimaryDark);
      expect(contrast, greaterThanOrEqualTo(4.5));
    });
    
    test('Error color vs White text contrast should be >= 4.5', () {
      final contrast = calculateContrastRatio(AppColors.error, Colors.white);
      expect(contrast, greaterThanOrEqualTo(4.5));
    });
  });
}


