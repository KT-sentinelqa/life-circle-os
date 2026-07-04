import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/typography/app_typography.dart';

void main() {
  group('AppTypography', () {
    test('displayLarge uses Inter font and correct properties', () {
      expect(AppTypography.displayLarge.fontFamily, 'Inter');
      expect(AppTypography.displayLarge.fontSize, 57);
    });

    test('headlineLarge uses Inter font and correct properties', () {
      expect(AppTypography.headlineLarge.fontFamily, 'Inter');
      expect(AppTypography.headlineLarge.fontSize, 32);
    });
    
    test('headlineMedium uses Inter font and correct properties', () {
      expect(AppTypography.headlineMedium.fontFamily, 'Inter');
      expect(AppTypography.headlineMedium.fontSize, 28);
    });
  });
}
