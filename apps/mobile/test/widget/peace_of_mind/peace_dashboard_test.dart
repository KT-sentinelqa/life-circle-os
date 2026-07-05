import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_circle_os/src/features/peace_of_mind/presentation/screens/peace_dashboard_screen.dart';
import 'package:life_circle_os/src/features/responsibilities/application/responsibility_providers.dart';
import 'package:life_circle_os/src/features/responsibilities/domain/models/family_responsibility.dart';

void main() {
  testWidgets('Peace Dashboard renders accessible semantics and all clear state', (WidgetTester tester) async {
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
    expect(find.text('All Clear. No exceptions require your attention.'), findsOneWidget);
    expect(find.text('100'), findsOneWidget); // Score is 100

    // Accessibility test: Should have Semantic label describing the score
    final semanticsFinder = find.bySemanticsLabel('High family confidence. Score is 100.');
    expect(semanticsFinder, findsOneWidget);
  });
}
