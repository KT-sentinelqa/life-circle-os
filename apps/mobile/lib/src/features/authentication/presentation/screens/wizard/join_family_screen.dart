import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';

/// Screen for joining an existing family via invite code.
class JoinFamilyScreen extends ConsumerStatefulWidget {
  /// Creates a [JoinFamilyScreen].
  const JoinFamilyScreen({super.key});

  @override
  ConsumerState<JoinFamilyScreen> createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends ConsumerState<JoinFamilyScreen> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _submit() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Join family functionality coming soon!'),
    //   ),
    // Fallback: Just pop to choice screen or go dashboard?
    // In real implementation, this would call familyStateProvider.joinFamily()
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return LcScaffold(
      appBar: AppBar(
        title: const Text('Join Family'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Invite Code',
                style: AppTypography.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Enter the 6-digit alphanumeric code '
                'provided by your family owner.',
                style: AppTypography.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.xl),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Invite Code',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
              const Spacer(),
              LcButton(
                text: 'Join',
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
