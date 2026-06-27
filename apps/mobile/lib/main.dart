/// LifeCircle OS — Application entry point.
///
/// Governed by: docs/mobile-architecture.md | docs/design-principles.md
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/auth/presentation/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enforce portrait orientation on mobile
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const LifeCircleApp());
}

/// Root application widget.
class LifeCircleApp extends StatelessWidget {
  const LifeCircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeCircle OS',
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const RegistrationScreen(),
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
