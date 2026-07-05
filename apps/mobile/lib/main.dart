/// LifeCircle OS — Application entry point.
///
/// Governed by: docs/mobile-architecture.md | docs/design-principles.md
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:lifecircle_mobile/src/core/config/router.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/core/storage/encryption_service.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_medicine_streak.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_family.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_invitation.dart';
import 'package:lifecircle_mobile/src/features/family/data/models/isar_member.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_dosage_schedule.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_medicine_log.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_prescription.dart';
import 'package:lifecircle_mobile/src/features/medicine/data/models/isar_reminder.dart';
import 'package:lifecircle_mobile/src/features/sync/data/outbox/outbox_entry_model.dart';

/// Initializes and runs the application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enforce portrait orientation on mobile
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize core storage services for Sprint 2.3
  const secureStorage = SecureStorageService(FlutterSecureStorage());
  final encryptionKey = await secureStorage.getOrCreateEncryptionKey();
  final databaseService = await DatabaseService.init([
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
  ]);

  runApp(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(secureStorage),
        encryptionServiceProvider.overrideWithValue(
          EncryptionService(encryptionKey),
        ),
        databaseServiceProvider.overrideWithValue(
          databaseService,
        ),
      ],
      child: const LifeCircleApp(),
    ),
  );
}

/// Root application widget.
class LifeCircleApp extends ConsumerWidget {
  /// Creates a [LifeCircleApp].
  const LifeCircleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'LifeCircle OS',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      routerConfig: goRouter,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E5BFF),
      ),
      fontFamily: 'Inter',
      // WCAG AA compliance: minimum 4.5:1 contrast ratio
      // Governed by: docs/accessibility.md
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E5BFF),
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
    );
  }
}
