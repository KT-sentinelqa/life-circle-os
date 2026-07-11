import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen to configure biometric unlock.
class BiometricSetupScreen extends ConsumerWidget {
  /// Creates a [BiometricSetupScreen].
  const BiometricSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider).isLoading;

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Fast Unlock'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.fingerprint_rounded,
                size: 80,
                color: Color(0xFF2E5BFF),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Unlock LifeCircle with biometrics.',
                style: AppTypography.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Use Face ID or Touch ID for fast, secure access without a password.',
                style: AppTypography.bodyLarge.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                LcButton(
                  text: 'Enable Biometrics',
                  onPressed: () => ref.read(authProvider.notifier).setupBiometric(),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => ref.read(authProvider.notifier).setupBiometric(), // Skips but progresses state for now
                  child: const Text('Skip for now'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
