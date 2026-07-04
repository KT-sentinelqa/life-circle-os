import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/design_system/theme/app_theme.dart';
import 'package:mobile/src/design_system/widgets/lc_scaffold.dart';

void main() {
  testWidgets('LcScaffold matches golden file (Light Mode)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LcScaffold(
          body: Center(child: Text('Scaffold Content')),
        ),
      ),
    );

    await expectLater(
      find.byType(LcScaffold),
      matchesGoldenFile('goldens/lc_scaffold_light.png'),
    );
  });
}
