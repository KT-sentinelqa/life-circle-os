/// LifeCircle OS — Application entry point.
///
/// Governed by: docs/mobile-architecture.md | docs/design-principles.md
library;

import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lifecircle_mobile/src/core/config/initial_session_provider.dart';
import 'package:lifecircle_mobile/src/core/config/router.dart';
import 'package:lifecircle_mobile/src/core/infrastructure/isar_provider.dart';
import 'package:lifecircle_mobile/src/core/navigation/page_transitions.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';
import 'package:lifecircle_mobile/src/core/storage/encryption_service.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/data/collections/isar_medicine_streak.dart';
import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/features/authentication/data/repositories/local_auth_repository.dart';
import 'package:lifecircle_mobile/src/features/authentication/data/repositories/production_auth_repository.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/splash_screen.dart';
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
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Show standalone splash screen immediately while we bootstrap
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );

  _bootstrap();
}

Future<void> _bootstrap() async {
  developer.log('BOOTSTRAP 1: Starting orientations');
  // Enforce portrait orientation on mobile
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);



  developer.log('BOOTSTRAP 3: Initializing SecureStorage');
  // Initialize core storage services for Sprint 2.3
  const secureStorage = SecureStorageService(FlutterSecureStorage());
  final encryptionKey = await secureStorage.getOrCreateEncryptionKey();
  
  developer.log('BOOTSTRAP 4: Initializing Isar Database');
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

  developer.log('BOOTSTRAP 5: Creating ProductionAuthRepository');
  // Pre-fetch the authentication session synchronously before the router is built
  final dio = Dio();
  final authRepository = ProductionAuthRepository(secureStorage, dio);
  
  developer.log('BOOTSTRAP 6: Checking Session');
  final user = await authRepository.checkSession();
  
  developer.log('BOOTSTRAP 7: Session Checked - $user. Switching to LifeCircleApp');

  runApp(
    ProviderScope(
      observers: const [
        // SEC-030 and QA-002: Track provider rebuilds for performance telemetry
        // Phase 6B Scaffold. The AnalyticsService should be constructed and passed here.
      ],
      overrides: [
        secureStorageProvider.overrideWithValue(secureStorage),
        encryptionServiceProvider.overrideWithValue(
          EncryptionService(encryptionKey),
        ),
        databaseServiceProvider.overrideWithValue(
          databaseService,
        ),
        isarProvider.overrideWithValue(
          databaseService.db,
        ),
        initialSessionProvider.overrideWithValue(user),
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
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      routerConfig: goRouter,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      fontFamily: 'Inter',
      pageTransitionsTheme: const LifeCirclePageTransitionsTheme(),
      // WCAG AA compliance: minimum 4.5:1 contrast ratio
      // Governed by: docs/accessibility.md
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      fontFamily: 'Inter',
      pageTransitionsTheme: const LifeCirclePageTransitionsTheme(),
    );
  }
}
