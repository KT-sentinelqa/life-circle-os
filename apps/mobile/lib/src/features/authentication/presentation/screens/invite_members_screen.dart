import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/src/design_system/spacing/app_spacing.dart';
import 'package:mobile/src/design_system/typography/app_typography.dart';
import 'package:mobile/src/design_system/widgets/lc_button.dart';
import 'package:mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:mobile/src/design_system/widgets/lc_text_field.dart';

/// Screen for optionally inviting members after family creation.
class InviteMembersScreen extends StatelessWidget {
  /// Creates an [InviteMembersScreen].
  const InviteMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Invite family members to share tasks, manage finances, and stay connected.',
              style: AppTypography.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.xl),
            const LcTextField(
              label: 'Email Address',
            ),
            const Spacer(),
            LcButton(
              text: 'Send Invite',
              onPressed: () {
                // Mock sending invite
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invite sent!')),
                );
                context.go('/dashboard');
              },
            ),
          ],
        ),
      ),
    );
  }
}
