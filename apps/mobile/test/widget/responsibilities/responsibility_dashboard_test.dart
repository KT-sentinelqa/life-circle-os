import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:life_circle_os/src/features/responsibilities/presentation/screens/responsibility_dashboard_screen.dart';
import 'package:life_circle_os/src/features/responsibilities/application/responsibility_providers.dart';

void main() {
  testWidgets('Dashboard renders empty peace-of-mind state', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          familyResponsibilitiesProvider.overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: ResponsibilityDashboardScreen(),
        ),
      ),
    );

    // Pump to settle the FutureProvider
    await tester.pumpAndSettle();

    expect(find.text('Family Responsibilities'), findsOneWidget);
    expect(find.text('All caught up. Peace of mind.'), findsOneWidget);
  });
}
