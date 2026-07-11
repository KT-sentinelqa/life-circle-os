import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen to configure two-factor authentication.
class TwoFactorSetupScreen extends ConsumerWidget {
  /// Creates a [TwoFactorSetupScreen].
  const TwoFactorSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider).isLoading;

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Security'),
        automaticallyImplyLeading: false, // Force them to complete it
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.shield_rounded,
                size: 64,
                color: Color(0xFF2E5BFF),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Protect your account.',
                style: AppTypography.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Two-factor authentication keeps your family safe.',
                style: AppTypography.bodyLarge.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                _buildOption(
                  icon: Icons.message_rounded,
                  title: 'SMS',
                  subtitle: 'Receive a code via text message',
                  onTap: () => ref.read(authProvider.notifier).setupTwoFactor('sms'),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildOption(
                  icon: Icons.qr_code_scanner_rounded,
                  title: 'Authenticator App',
                  subtitle: 'Use Google Authenticator or Authy',
                  onTap: () => ref.read(authProvider.notifier).setupTwoFactor('totp'),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildOption(
                  icon: Icons.fingerprint_rounded,
                  title: 'Passkey',
                  subtitle: 'Fast, secure sign-in without passwords',
                  onTap: () => ref.read(authProvider.notifier).setupTwoFactor('passkey'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: const Color(0xFF2E5BFF)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
