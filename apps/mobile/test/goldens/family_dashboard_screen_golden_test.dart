import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_medicine_streak.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/services/demo_seed_engine.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_family.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_invitation.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_member.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/screens/family_dashboard_screen.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_dosage_schedule.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine_log.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_prescription.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_reminder.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_entry_model.dart';

void main() {
  late DatabaseService dbService;

  setUp(() async {
    await Isar.initializeIsarCore(download: true);
    final dir = Directory.systemTemp.createTempSync('demo_test_db_family');
    final isar = await Isar.open(
      [
        IsarFamilySchema,
        IsarMemberSchema,
        IsarInvitationSchema,
        IsarOutboxEntrySchema,
        IsarAdherenceRecordSchema,
        IsarMedicineStreakSchema,
        IsarMedicineSchema,
        IsarDosageScheduleSchema,
        IsarMedicineLogSchema,
        IsarPrescriptionSchema,
        IsarReminderSchema,
      ],
      directory: dir.path,
    );
    dbService = DatabaseService.test(isar);

    // Populate data
    final engine = DemoSeedEngine(databaseService: dbService);
    await engine.populateDemoScenario(
      DemoScenario.healthyFamily,
      DateTime.utc(2026, 7),
    );
  });

  tearDown(() async {
    final isar = dbService.db;
    await isar.close(deleteFromDisk: true);
  });

  testWidgets('FamilyDashboardScreen Golden', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseServiceProvider.overrideWithValue(dbService),
        ],
        child: MaterialApp(
          themeMode: ThemeMode.light,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
            ),
            scaffoldBackgroundColor: AppColors.backgroundLight,
          ),
          home: const FamilyDashboardScreen(),
        ),
      ),
    );

    // We use pump(Duration) instead of pumpAndSettle to avoid infinite
    // animation timeouts
    await tester.pump(const Duration(seconds: 1));

    await expectLater(
      find.byType(FamilyDashboardScreen),
      matchesGoldenFile('family_dashboard_screen_light.png'),
    );
  });
}
