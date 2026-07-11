import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/peace_of_mind/presentation/screens/peace_dashboard_screen.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/application/responsibility_providers.dart';

void main() {
  testWidgets(
      'Peace Dashboard renders accessible semantics and all clear state',
      (WidgetTester tester) async {
    final semantics = tester.ensureSemantics();
    
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          familyResponsibilitiesProvider.overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: PeaceDashboardScreen(currentUserId: 'user_1'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify Semantics and text
    expect(find.text('Exception Dashboard'), findsOneWidget);
    expect(
      find.text('All Clear. No exceptions require your attention.'),
      findsOneWidget,
    );
    expect(find.text('100'), findsOneWidget); // Score is 100

    // Accessibility test: Match exact semantics exposed by ConfidenceIndicator
    expect(
      find.bySemanticsLabel('High family confidence. Score is 100.'),
      findsOneWidget,
    );
    
    semantics.dispose();
  });
}
