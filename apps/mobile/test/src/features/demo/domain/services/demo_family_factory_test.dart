import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_family_factory.dart';

void main() {
  group('DemoFamilyFactory', () {
    test('generateFamily creates healthy family correctly', () {
      const factory = DemoFamilyFactory();
      final (family, members) =
          factory.generateFamily(DemoScenario.healthyFamily);

      expect(family.name, 'The Healthy Family');
      expect(members.length, 2);
      expect(members.any((m) => m.userId.contains('owner')), isTrue);
      expect(members.any((m) => m.userId.contains('father')), isTrue);
    });
  });
}
