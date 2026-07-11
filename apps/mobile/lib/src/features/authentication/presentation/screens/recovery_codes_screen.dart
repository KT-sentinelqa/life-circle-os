import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen to generate and save recovery codes.
class RecoveryCodesScreen extends ConsumerWidget {
  /// Creates a [RecoveryCodesScreen].
  const RecoveryCodesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authProvider).isLoading;
    final codes = [
      'A1B2-C3D4', 'E5F6-G7H8', 'I9J0-K1L2', 'M3N4-O5P6',
      'Q7R8-S9T0', 'U1V2-W3X4', 'Y5Z6-A7B8', 'C9D0-E1F2',
    ];

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Recovery Codes'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.key_rounded,
                size: 64,
                color: Color(0xFF2E5BFF),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Save your recovery codes',
                style: AppTypography.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'If you lose your device or cannot receive codes, these recovery codes will grant access to your account. Keep them in a safe place.',
                style: AppTypography.bodyLarge.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: codes.map((code) => Text(
                    code,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 2,
                    ),
                  ),).toList(),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.copy_rounded),
                    label: const Text('Copy'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('Download'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.print_rounded),
                    label: const Text('Print'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                LcButton(
                  text: 'I have saved these codes',
                  onPressed: () => ref.read(authProvider.notifier).completeAuthPipeline(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
