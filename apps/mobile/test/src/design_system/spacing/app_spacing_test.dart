import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/spacing/app_spacing.dart';

void main() {
  group('AppSpacing Tests', () {
    test('Spacing constants have exact pixel values', () {
      expect(AppSpacing.xs, 4.0);
      expect(AppSpacing.sm, 8.0);
      expect(AppSpacing.md, 16.0);
      expect(AppSpacing.lg, 24.0);
      expect(AppSpacing.xl, 32.0);
      expect(AppSpacing.xxl, 48.0);
    });
  });
}
