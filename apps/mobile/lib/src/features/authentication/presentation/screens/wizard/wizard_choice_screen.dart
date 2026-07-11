import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';

/// Screen where users choose to create a new family or join an existing one.
class WizardChoiceScreen extends ConsumerStatefulWidget {
  /// Creates a [WizardChoiceScreen].
  const WizardChoiceScreen({super.key});

  @override
  ConsumerState<WizardChoiceScreen> createState() => _WizardChoiceScreenState();
}

class _WizardChoiceScreenState extends ConsumerState<WizardChoiceScreen> {
  String? _selectedFamilyType;

  void _continue() {
    if (_selectedFamilyType == null) return;
    
    // For Developer Alpha, we just mock that the family setup is complete
    // by pushing directly to the dashboard, or we can mock the familyId update.
    // In Phase 4, this will trigger the real family creation API.
    
    // Navigate to dashboard
    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).valueOrNull;
    final firstName = user?.name.split(' ').first ?? 'User';

    return LcScaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Welcome $firstName 👋',
                style: AppTypography.displayMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                "Let's build your family.",
                style: AppTypography.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.xl),
              _buildOption('Self'),
              const SizedBox(height: AppSpacing.sm),
              _buildOption('Couple'),
              const SizedBox(height: AppSpacing.sm),
              _buildOption('Parents'),
              const SizedBox(height: AppSpacing.sm),
              _buildOption('Joint Family'),
              const Spacer(),
              LcButton(
                text: 'Continue',
                onPressed: _selectedFamilyType != null ? _continue : null,
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String title) {
    final isSelected = _selectedFamilyType == title;
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() {
          _selectedFamilyType = title;
        });
      },
      borderRadius: BorderRadius.circular(AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF2E5BFF) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.md),
          color: isSelected
              ? const Color(0xFF2E5BFF).withAlpha(13) // 0.05 opacity
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? const Color(0xFF2E5BFF) : Colors.grey.shade500,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              title,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
