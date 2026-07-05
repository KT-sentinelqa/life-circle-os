import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/demo/domain/entities/demo_scenario.dart';
import 'package:lifecircle_mobile/src/features/demo/presentation/providers/demo_seed_provider.dart';

/// Introductory screen explaining the value of LifeCircle OS.
class OnboardingScreen extends ConsumerWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LcScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text(
                'The Operating System for Indian Families.',
                style: AppTypography.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Manage your household, finances, health, and family all '
                'in one secure, offline-first place.',
                style: AppTypography.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              LcButton(
                text: 'Get Started',
                onPressed: () => context.go('/auth'),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: () async {
                  await ref.read(demoSeedEngineProvider).populateDemoScenario(
                        DemoScenario.standardIndianFamily,
                        DateTime.utc(2026, 7),
                      );
                  const demoUser = User(
                    id: 'user-krishna-1',
                    name: 'Krishna Tiwari',
                    email: 'krishna@demo.com',
                    familyId: 'demo-family-123',
                  );
                  await ref
                      .read(authProvider.notifier)
                      .forceDemoLogin(demoUser);
                },
                child: const Text('Try Demo Family'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
