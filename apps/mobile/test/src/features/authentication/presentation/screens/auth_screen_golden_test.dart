import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/theme/app_theme.dart';
import 'package:mobile/src/features/authentication/presentation/screens/auth_screen.dart';

void main() {
  Widget buildTestWidget(Widget child, {bool isDark = false}) {
    return ProviderScope(
      child: MaterialApp(
        theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: child,
      ),
    );
  }

  testWidgets('AuthScreen matches golden file (Light Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(const AuthScreen()),
    );
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    );

    await expectLater(
      find.byType(AuthScreen),
      matchesGoldenFile('goldens/auth_screen_light.png'),
    );
  });

  testWidgets('AuthScreen matches golden file (Dark Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(const AuthScreen(), isDark: true),
    );
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    );

    await expectLater(
      find.byType(AuthScreen),
      matchesGoldenFile('goldens/auth_screen_dark.png'),
    );
  });
}
