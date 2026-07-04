import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';

/// Introductory screen explaining the value of LifeCircle OS.
class OnboardingScreen extends StatelessWidget {
  /// Creates an [OnboardingScreen].
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            ],
          ),
        ),
      ),
    );
  }
}
