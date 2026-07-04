import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen for creating the aggregate root Family entity.
class CreateFamilyScreen extends ConsumerStatefulWidget {
  /// Creates a [CreateFamilyScreen].
  const CreateFamilyScreen({super.key});

  @override
  ConsumerState<CreateFamilyScreen> createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends ConsumerState<CreateFamilyScreen> {
  final _familyNameController = TextEditingController();

  @override
  void dispose() {
    _familyNameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_familyNameController.text.isNotEmpty) {
      unawaited(
        ref.read(authProvider.notifier).createFamily(
              _familyNameController.text,
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Create Family'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Set up your LifeCircle',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Your family is the center of your operating system. '
              'Give it a name to get started.',
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            LcTextField(
              label: 'Family Name',
              controller: _familyNameController,
            ),
            const Spacer(),
            if (authState.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              LcButton(
                text: 'Create Family',
                onPressed: _submit,
              ),
          ],
        ),
      ),
    );
  }
}
