import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/screens/onboarding_screen.dart';

void main() {
  testWidgets('OnboardingScreen Light Mode Golden', (tester) async {
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

    await expectLater(
      find.byType(OnboardingScreen),
      matchesGoldenFile('onboarding_screen_light.png'),
    );
  });

  testWidgets('OnboardingScreen Dark Mode Golden', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          themeMode: ThemeMode.dark,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const OnboardingScreen(),
        ),
      ),
    );

    await tester.pump(const Duration(milliseconds: 500));

    await expectLater(
      find.byType(OnboardingScreen),
      matchesGoldenFile('onboarding_screen_dark.png'),
    );
  });
}
