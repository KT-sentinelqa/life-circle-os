import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/colors/app_colors.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/authentication/application/demo_service.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen for initiating login or registration via OTP.
class AuthScreen extends ConsumerStatefulWidget {
  /// Creates an [AuthScreen].
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _identifierController = TextEditingController();

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }

  void _submit() {
    final identifier = _identifierController.text.trim();
    if (identifier.isEmpty) return;

    unawaited(
      ref.read(authProvider.notifier).requestOtp(identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen(
      authProvider,
      (previous, next) {
        if (!next.isLoading && !next.hasError) {
          // If loading finished and no error, route to OTP screen
          // We check previous.isLoading to ensure we only trigger after a submit.
          if (previous != null && previous.isLoading) {
            context.push('/auth/otp', extra: _identifierController.text.trim());
          }
        } else if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send OTP: ${next.error}'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
    );

    return LcScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Text(
                'Welcome to LifeCircle',
                style: AppTypography.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'The Operating System\nfor Every Family.',
                style: AppTypography.displayMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Helping every family in the world live with less stress, more clarity, and stronger connections.',
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              LcTextField(
                label: 'Mobile Number or Email',
                controller: _identifierController,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (authState.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                LcButton(
                  text: 'Continue',
                  onPressed: _submit,
                ),
              const SizedBox(height: AppSpacing.xl),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text('OR'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text('Continue with Google'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(AppSpacing.md),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.apple, size: 24),
                label: const Text('Continue with Apple'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(AppSpacing.md),
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
