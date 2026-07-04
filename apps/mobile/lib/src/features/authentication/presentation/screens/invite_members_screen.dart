import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_provider.dart';

/// Screen for optionally inviting members after family creation.
class InviteMembersScreen extends ConsumerStatefulWidget {
  const InviteMembersScreen({super.key});

  @override
  ConsumerState<InviteMembersScreen> createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends ConsumerState<InviteMembersScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_emailController.text.isNotEmpty) {
      unawaited(
        ref.read(familyStateProvider.notifier).inviteMember(_emailController.text).then((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invite sent!')),
            );
            context.go('/dashboard');
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final familyState = ref.watch(familyStateProvider);

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Invite Members'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => context.go('/dashboard'),
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Who else is in your LifeCircle?',
              style: AppTypography.headlineLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Invite family members to share tasks, manage finances, '
              'and stay connected.',
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            LcTextField(
              label: 'Email Address',
              controller: _emailController,
            ),
            const Spacer(),
            if (familyState.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              LcButton(
                text: 'Send Invite',
                onPressed: _submit,
              ),
          ],
        ),
      ),
    );
  }
}
