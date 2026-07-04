/// LifeCircle OS — Application entry point.
///
/// Governed by: docs/mobile-architecture.md | docs/design-principles.md
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/core/config/router.dart';
import 'src/core/storage/secure_storage_service.dart';
import 'src/core/storage/encryption_service.dart';
import 'src/core/storage/database_service.dart';
import 'src/features/family/data/models/isar_family.dart';
import 'src/features/family/data/models/isar_member.dart';
import 'src/features/family/data/models/isar_invitation.dart';
import 'src/features/sync/data/outbox/outbox_entry_model.dart';

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
  ]);

  runApp(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(secureStorage),
        encryptionServiceProvider.overrideWithValue(EncryptionService(encryptionKey)),
        databaseServiceProvider.overrideWithValue(databaseService),
      ],
      child: const LifeCircleApp(),
    ),
  );
}

/// Root application widget.
class LifeCircleApp extends ConsumerWidget {
  const LifeCircleApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'LifeCircle OS',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      routerConfig: goRouter,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E5BFF),
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      // WCAG AA compliance: minimum 4.5:1 contrast ratio
      // Governed by: docs/accessibility.md
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E5BFF),
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
    );
  }
}
