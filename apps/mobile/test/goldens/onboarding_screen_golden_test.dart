import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/onboarding_screen.dart';

void main() {
  testWidgets('OnboardingScreen Light Mode Flow Golden', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          themeMode: ThemeMode.light,
          home: OnboardingScreen(),
        ),
      ),
    );

    // Wait for initial breathing gradient setup
    await tester.pump(const Duration(milliseconds: 500));

    // Page 1
    await expectLater(
      find.byType(OnboardingScreen),
      matchesGoldenFile('onboarding_screen_page_1_light.png'),
    );

    // Page 2
    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await expectLater(
      find.byType(OnboardingScreen),
      matchesGoldenFile('onboarding_screen_page_2_light.png'),
    );

    // Page 3
    await tester.tap(find.text('Next'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    await expectLater(
      find.byType(OnboardingScreen),
      matchesGoldenFile('onboarding_screen_page_3_light.png'),
    );
  });
}
