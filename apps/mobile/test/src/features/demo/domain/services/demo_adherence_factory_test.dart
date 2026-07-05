import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_adherence_factory.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_family_factory.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_medicine_factory.dart';

void main() {
  group('DemoAdherenceFactory', () {
    test('generateHistory produces 90 days of deterministic records', () {
      const familyFactory = DemoFamilyFactory();
      const medicineFactory = DemoMedicineFactory();
      const adherenceFactory = DemoAdherenceFactory();
      final referenceTime = DateTime.utc(2026, 7);

      final (family, members) =
          familyFactory.generateFamily(DemoScenario.healthyFamily);
      final medicines = medicineFactory.generateMedicines(
        members,
        DemoScenario.healthyFamily,
        referenceTime,
      );

      final records = adherenceFactory.generateHistory(
        members: members,
        medicines: medicines,
        referenceTime: referenceTime,
        scenario: DemoScenario.healthyFamily,
      );

      // Members with meds: 4 (son, dil, father, mother). So 4 * 90 = 360 records
      expect(
        records.length,
        equals(360),
      );

      // Ensure deterministic behavior
      final firstRecord = records.first;
      final sameRecords = adherenceFactory.generateHistory(
        members: members,
        medicines: medicines,
        referenceTime: referenceTime,
        scenario: DemoScenario.healthyFamily,
      );
      expect(firstRecord.status, sameRecords.first.status);
      expect(firstRecord.dosesTaken, sameRecords.first.dosesTaken);
    });
  });
}
