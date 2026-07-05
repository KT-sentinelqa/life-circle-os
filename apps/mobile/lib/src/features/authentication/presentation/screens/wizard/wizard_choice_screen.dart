import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';

/// Screen where users choose to create a new family or join an existing one.
class WizardChoiceScreen extends StatelessWidget {
  /// Creates a [WizardChoiceScreen].
  const WizardChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LcScaffold(
      appBar: AppBar(
        title: const Text('Setup LifeCircle'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Icon(
                Icons.family_restroom,
                size: 80,
                color: Color(0xFF2E5BFF),
              ),
              const SizedBox(height: AppSpacing.xl),
              const Text(
                "Let's get started",
                style: AppTypography.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Are you setting up a new family or joining an existing one?',
                style: AppTypography.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              LcButton(
                text: 'Create New Family',
                onPressed: () => context.push('/wizard/create'),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  context.push('/wizard/join');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.sm),
                  ),
                ),
                child: const Text(
                  'Join Existing Family',
                  style: AppTypography.bodyLarge,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
