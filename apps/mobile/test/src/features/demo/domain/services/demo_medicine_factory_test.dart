import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_family_factory.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_medicine_factory.dart';

void main() {
  group('DemoMedicineFactory', () {
    test('generateMedicines produces correct meds for standard family', () {
      const familyFactory = DemoFamilyFactory();
      const medicineFactory = DemoMedicineFactory();
      final referenceTime = DateTime.utc(2026, 7);

      final (_, members) =
          familyFactory.generateFamily(DemoScenario.healthyFamily);
      final medicines = medicineFactory.generateMedicines(
        members,
        DemoScenario.healthyFamily,
        referenceTime,
      );

      // Total expected: Father (1), Owner (1) = 2
      expect(medicines.length, 2);
      expect(medicines.any((m) => m.name == 'Vitamin D3'), isTrue);
      expect(medicines.any((m) => m.name == 'Multivitamin'), isTrue);
      expect(
        medicines.every((m) => m.updatedAtUtc == referenceTime),
        isTrue,
      );
    });
  });
}
