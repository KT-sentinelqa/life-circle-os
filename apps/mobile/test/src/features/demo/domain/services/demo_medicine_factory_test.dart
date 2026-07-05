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
          familyFactory.generateFamily(DemoScenario.standardIndianFamily);
      final medicines = medicineFactory.generateMedicines(
        members,
        DemoScenario.standardIndianFamily,
        referenceTime,
      );

      // Total expected: Grandma (4), Father (2), Mother (2), Owner (1) = 9
      expect(medicines.length, 9);
      expect(medicines.any((m) => m.name == 'Amlodipine'), isTrue);
      expect(medicines.any((m) => m.name == 'Multivitamin'), isTrue);
      expect(
        medicines.every((m) => m.updatedAtUtc == referenceTime),
        isTrue,
      );
    });
  });
}
