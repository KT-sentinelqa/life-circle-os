import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/theme/app_theme.dart';
import 'package:mobile/src/features/authentication/presentation/screens/create_family_screen.dart';

void main() {
  Widget buildTestWidget(Widget child, {bool isDark = false}) {
    return ProviderScope(
      child: MaterialApp(
        theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
        home: child,
      ),
    );
  }

  testWidgets('CreateFamilyScreen matches golden file (Light Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(const CreateFamilyScreen()),
    );
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    );

    await expectLater(
      find.byType(CreateFamilyScreen),
      matchesGoldenFile('goldens/create_family_screen_light.png'),
    );
  });
}
