import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/elevation/app_elevation.dart';

void main() {
  group('AppElevation Tests', () {
    test('Elevation constants have exact double values', () {
      expect(AppElevation.none, 0.0);
      expect(AppElevation.level1, 1.0);
      expect(AppElevation.level2, 3.0);
      expect(AppElevation.level3, 6.0);
      expect(AppElevation.level4, 8.0);
      expect(AppElevation.level5, 12.0);
    });
  });
}
