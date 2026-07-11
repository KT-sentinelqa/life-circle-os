import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen for creating a new LifeCircle account.
class CreateAccountScreen extends ConsumerStatefulWidget {
  /// Creates a [CreateAccountScreen].
  const CreateAccountScreen({super.key});

  @override
  ConsumerState<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends ConsumerState<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _identifierController = TextEditingController();
  final _countryController = TextEditingController(text: 'India');

  @override
  void dispose() {
    _nameController.dispose();
    _identifierController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _submit() {
    final identifier = _identifierController.text.trim();
    if (identifier.isEmpty) return;

    ref.read(authProvider.notifier).requestOtp(identifier);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    ref.listen(
      authProvider,
      (previous, next) {
        if (!next.isLoading && !next.hasError) {
          if (previous != null && previous.isLoading) {
            context.push('/auth/otp', extra: _identifierController.text.trim());
          }
        }
      },
    );

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.lg),
              const Text(
                'Join LifeCircle',
                style: AppTypography.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Create your family space.',
                style: AppTypography.bodyLarge.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: AppSpacing.xl),
              LcTextField(
                label: 'Full Name',
                controller: _nameController,
              ),
              const SizedBox(height: AppSpacing.md),
              LcTextField(
                label: 'Email or Mobile Number',
                controller: _identifierController,
              ),
              const SizedBox(height: AppSpacing.md),
              LcTextField(
                label: 'Country',
                controller: _countryController,
              ),
              const SizedBox(height: AppSpacing.xl),
              if (authState.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                LcButton(
                  text: 'Continue',
                  onPressed: _submit,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
