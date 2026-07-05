import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_adherence_record.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_seed_engine.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_family.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_member.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine.dart';

void main() {
  group('DemoSeedEngine', () {
    late DatabaseService dbService;

    setUp(() async {
      await Isar.initializeIsarCore(download: true);
      final dir = Directory.systemTemp.createTempSync('demo_test_db');
      final isar = await Isar.open(
        [
          IsarFamilySchema,
          IsarMemberSchema,
          IsarMedicineSchema,
          IsarAdherenceRecordSchema,
        ],
        directory: dir.path,
      );
      dbService = DatabaseService.test(isar);
    });

    tearDown(() async {
      final isar = dbService.db;
      await isar.close(deleteFromDisk: true);
    });

    test('populateDemoScenario injects data bypassing domain logic', () async {
      final engine = DemoSeedEngine(databaseService: dbService);
      final refTime = DateTime.utc(2026, 7);

      await engine.populateDemoScenario(
        DemoScenario.healthyFamily,
        DateTime.utc(2026, 7, 1),
      );

      final isar = dbService.db;
      expect(await isar.isarFamilys.count(), 1);
      expect(await isar.isarMembers.count(), 5);
      expect(await isar.isarMedicines.count(), 9);
      expect(await isar.isarAdherenceRecords.count(), 360);
    });
  });
}
