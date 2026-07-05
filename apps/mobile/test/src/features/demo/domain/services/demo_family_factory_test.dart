import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_family_factory.dart';

void main() {
  group('DemoFamilyFactory', () {
    test('generateFamily creates standard Indian family correctly', () {
      const factory = DemoFamilyFactory();
      final (family, members) =
          factory.generateFamily(DemoScenario.standardIndianFamily);

      expect(family.name, 'The Tiwari Family');
      expect(members.length, 5);
      expect(members.any((m) => m.userId.contains('krishna')), isTrue);
      expect(members.any((m) => m.userId.contains('grandma')), isTrue);
    });
  });
}
