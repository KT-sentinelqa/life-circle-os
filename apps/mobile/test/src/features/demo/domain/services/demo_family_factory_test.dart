import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_family_factory.dart';

void main() {
  group('DemoFamilyFactory', () {
    test('generateFamily creates healthy family correctly', () {
      const factory = DemoFamilyFactory();
      final (family, members) =
          factory.generateFamily(DemoScenario.healthyFamily);

      expect(family.name, 'The Sharma Family');
      expect(members.length, 5);
      expect(members.any((m) => m.userId == 'user-son'), isTrue);
      expect(members.any((m) => m.userId == 'user-dil'), isTrue);
      expect(members.any((m) => m.userId == 'user-father'), isTrue);
      expect(members.any((m) => m.userId == 'user-mother'), isTrue);
      expect(members.any((m) => m.userId == 'user-child'), isTrue);
    });
  });
}
