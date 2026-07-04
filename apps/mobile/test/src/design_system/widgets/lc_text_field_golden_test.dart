import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/theme/app_theme.dart';
import 'package:mobile/src/design_system/widgets/lc_text_field.dart';

void main() {
  Widget buildTestWidget(Widget child, {bool isDark = false}) {
    return MaterialApp(
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('LcTextField matches golden file (Light Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const LcTextField(label: 'Email Address'),
      ),
    );

    await expectLater(
      find.byType(LcTextField),
      matchesGoldenFile('goldens/lc_text_field_light.png'),
    );
  });
}
