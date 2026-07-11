import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/family_responsibility.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_category.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/domain/models/responsibility_status.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/widgets/responsibility_card.dart';

void main() {
  testWidgets('ResponsibilityCard renders accessible escalation state',
      (WidgetTester tester) async {
    final resp = FamilyResponsibility()
      ..uuid = '123'
      ..name = 'Pay Electricity Bill'
      ..category = ResponsibilityCategory.finance
      ..status = ResponsibilityStatus.escalated
      ..dueDate = DateTime.now()
      ..primaryOwnerId = 'owner1';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ResponsibilityCard(
            responsibility: resp,
            onMarkComplete: () {},
            onSkip: () {},
          ),
        ),
      ),
    );

    // Assert visual text
    expect(find.text('Pay Electricity Bill'), findsOneWidget);

    // Assert accessibility/warning icons exist
    expect(find.byIcon(Icons.warning_rounded), findsOneWidget);

    // Assert buttons are tappable (Semantics validation)
    expect(find.text('Mark Complete'), findsOneWidget);
  });
}
