import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/features/finance/presentation/widgets/emi_intelligence_card.dart';
import 'package:lifecircle_mobile/src/features/protection/presentation/widgets/insurance_center_card.dart';
import 'package:lifecircle_mobile/src/features/responsibilities/presentation/widgets/responsibility_delegation_card.dart';

void main() {
  Widget buildTestApp(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
          ),
          scaffoldBackgroundColor: AppColors.backgroundLight,
        ),
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('EmiIntelligenceCard Golden', (tester) async {
    await tester.pumpWidget(buildTestApp(const EmiIntelligenceCard()));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(EmiIntelligenceCard),
      matchesGoldenFile('emi_intelligence_card_light.png'),
    );
  });

  testWidgets('InsuranceCenterCard Golden', (tester) async {
    await tester.pumpWidget(buildTestApp(const InsuranceCenterCard()));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(InsuranceCenterCard),
      matchesGoldenFile('insurance_center_card_light.png'),
    );
  });

  testWidgets('ResponsibilityDelegationCard Golden', (tester) async {
    await tester.pumpWidget(buildTestApp(const ResponsibilityDelegationCard()));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(ResponsibilityDelegationCard),
      matchesGoldenFile('responsibility_delegation_card_light.png'),
    );
  });
}
