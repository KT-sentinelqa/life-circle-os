import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/adherence_summary_card.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/current_streak_card.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/missed_dose_patterns_card.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/widgets/weekly_insights_card.dart';

void main() {
  testWidgets('Adherence Cards render correctly and contain semantics',
      (WidgetTester tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AdherenceSummaryCard(),
                  CurrentStreakCard(),
                  WeeklyInsightsCard(),
                  MissedDosePatternsCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Should find loading indicators for the async cards
    expect(find.byType(CircularProgressIndicator), findsWidgets);

    // MissedDosePatternsCard is static for now
    expect(find.text('Missed Dose Patterns'), findsOneWidget);
    expect(
      find.bySemanticsLabel('Missed Dose Patterns: Data unavailable.'),
      findsOneWidget,
    );

    semantics.dispose();
  });
}
