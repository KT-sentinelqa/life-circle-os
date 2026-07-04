import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/theme/app_theme.dart';
import 'package:mobile/src/design_system/widgets/lc_button.dart';

void main() {
  Widget buildTestWidget(Widget child, {bool isDark = false}) {
    return MaterialApp(
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  testWidgets('LcButton matches golden file (Light Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        LcButton(
          text: 'Primary Button',
          onPressed: () {},
        ),
      ),
    );

    await expectLater(
      find.byType(LcButton),
      matchesGoldenFile('goldens/lc_button_light.png'),
    );
  });

  testWidgets('LcButton matches golden file (Dark Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        LcButton(
          text: 'Primary Button',
          onPressed: () {},
        ),
        isDark: true,
      ),
    );

    await expectLater(
      find.byType(LcButton),
      matchesGoldenFile('goldens/lc_button_dark.png'),
    );
  });
}
