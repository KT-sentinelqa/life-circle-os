import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen to register the current device as trusted.
class DeviceTrustScreen extends ConsumerWidget {
  /// Creates a [DeviceTrustScreen].
  const DeviceTrustScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider).isLoading;

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Device Trust'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.devices_rounded,
                size: 64,
                color: Color(0xFF2E5BFF),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Register this device.',
                style: AppTypography.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Add this device to your trusted devices list to verify future sign-ins.',
                style: AppTypography.bodyLarge.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Mock Device Info
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    Icon(Icons.apple_rounded, size: 40, color: Colors.grey.shade800),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('MacBook Pro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('Location: San Francisco, CA', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                          Text('Trust Score: 100/100', style: TextStyle(color: Colors.green.shade600, fontSize: 13, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                LcButton(
                  text: 'Register Device',
                  onPressed: () => ref.read(authProvider.notifier).registerDevice('MacBook Pro'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
