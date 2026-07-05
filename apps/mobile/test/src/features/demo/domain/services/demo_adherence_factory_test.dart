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

      final (_, members) =
          familyFactory.generateFamily(DemoScenario.standardIndianFamily);
      final medicines = medicineFactory.generateMedicines(
        members,
        DemoScenario.standardIndianFamily,
        referenceTime,
      );

      final records = adherenceFactory.generateHistory(
        members: members,
        medicines: medicines,
        referenceTime: referenceTime,
      );

      // Members with meds: 4. So 4 * 90 = 360 records
      expect(records.length, 360);

      // Ensure deterministic behavior
      final firstRecord = records.first;
      final sameRecords = adherenceFactory.generateHistory(
        members: members,
        medicines: medicines,
        referenceTime: referenceTime,
      );
      expect(firstRecord.status, sameRecords.first.status);
      expect(firstRecord.dosesTaken, sameRecords.first.dosesTaken);
    });
  });
}
