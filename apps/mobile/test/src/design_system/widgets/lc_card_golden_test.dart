import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/theme/app_theme.dart';
import 'package:mobile/src/design_system/widgets/lc_card.dart';

void main() {
  Widget buildTestWidget(Widget child, {bool isDark = false}) {
    return MaterialApp(
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: Scaffold(
        body: Center(child: child),
      ),
    );
  }

  testWidgets('LcCard matches golden file (Light Mode)', (tester) async {
    await tester.pumpWidget(
      buildTestWidget(
        const LcCard(
          child: SizedBox(
            width: 200,
            height: 100,
            child: Center(child: Text('Card Content')),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(LcCard),
      matchesGoldenFile('goldens/lc_card_light.png'),
    );
  });
}
