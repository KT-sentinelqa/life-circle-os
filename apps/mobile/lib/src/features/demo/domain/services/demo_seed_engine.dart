import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_adherence_record.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_adherence_factory.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_family_factory.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_medicine_factory.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_family.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_member.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine.dart';

/// Core orchestrator for bypassing domain logic to forcibly populate the
/// database with rich, deterministic demo data.
class DemoSeedEngine {
  /// Creates a [DemoSeedEngine].
  const DemoSeedEngine({required this.databaseService});

  /// The underlying Isar database service.
  final DatabaseService databaseService;

  /// Generates the provided scenario and writes it directly to Isar.
  Future<void> populateDemoScenario(
    DemoScenario scenario,
    DateTime referenceTime,
  ) async {
    const familyFactory = DemoFamilyFactory();
    const medicineFactory = DemoMedicineFactory();
    const adherenceFactory = DemoAdherenceFactory();

    // 1. Generate Pure Domain Entities
    final (family, members) = familyFactory.generateFamily(scenario);
    final medicines =
        medicineFactory.generateMedicines(members, scenario, referenceTime);
    final records = adherenceFactory.generateHistory(
      members: members,
      medicines: medicines,
      referenceTime: referenceTime,
      scenario: scenario,
    );

    // 2. Map to Isar Data Models
    final isarFamily = IsarFamily.fromDomain(family);
    final isarMembers = members.map(IsarMember.fromDomain).toList();
    final isarMedicines = medicines.map(IsarMedicine.fromEntity).toList();
    final isarRecords = records.map(IsarAdherenceRecord.fromEntity).toList();

    // 3. Persist Directly to Isar (Bypass all domain logic/validators)
    final isar = databaseService.db;
    await isar.writeTxn(() async {
      // Clean slate for deterministic switching
      await isar.clear();

      await isar.isarFamilys.put(isarFamily);
      await isar.isarMembers.putAll(isarMembers);
      await isar.isarMedicines.putAll(isarMedicines);
      await isar.isarAdherenceRecords.putAll(isarRecords);
    });
  }
}
