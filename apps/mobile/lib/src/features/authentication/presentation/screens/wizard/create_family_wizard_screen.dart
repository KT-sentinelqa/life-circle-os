import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/family_wizard_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_provider.dart';

/// Orchestrates the multi-step family creation flow.
class CreateFamilyWizardScreen extends ConsumerWidget {
  /// Creates a [CreateFamilyWizardScreen].
  const CreateFamilyWizardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyWizardProvider);
    final notifier = ref.read(familyWizardProvider.notifier);

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Create Family'),
        leading: state.currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: notifier.prevStep,
              )
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  notifier.reset();
                  context.pop();
                },
              ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildStepContent(context, ref, state),
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    WidgetRef ref,
    FamilyWizardState state,
  ) {
    switch (state.currentStep) {
      case 0:
        return const _FamilyNameStep(key: ValueKey('step0'));
      case 1:
        return const _AddParentsStep(key: ValueKey('step1'));
      case 2:
        return const _AssignCaregiverStep(key: ValueKey('step2'));
      case 3:
        return const _ReviewStep(key: ValueKey('step3'));
      default:
        return const SizedBox.shrink(key: ValueKey('empty'));
    }
  }
}

class _FamilyNameStep extends ConsumerStatefulWidget {
  const _FamilyNameStep({super.key});

  @override
  ConsumerState<_FamilyNameStep> createState() => _FamilyNameStepState();
}

class _FamilyNameStepState extends ConsumerState<_FamilyNameStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(familyWizardProvider).familyName,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'What is your family name?',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xl),
        LcTextField(
          label: 'Family Name (e.g., The Tiwaris)',
          controller: _controller,
        ),
        const Spacer(),
        LcButton(
          text: 'Continue',
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              ref
                  .read(familyWizardProvider.notifier)
                  .updateFamilyName(_controller.text);
              ref.read(familyWizardProvider.notifier).nextStep();
            }
          },
        ),
      ],
    );
  }
}

class _AddParentsStep extends ConsumerStatefulWidget {
  const _AddParentsStep({super.key});

  @override
  ConsumerState<_AddParentsStep> createState() => _AddParentsStepState();
}

class _AddParentsStepState extends ConsumerState<_AddParentsStep> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addParent() {
    if (_controller.text.isNotEmpty) {
      ref.read(familyWizardProvider.notifier).addParent(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(familyWizardProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Add Parents or Elders',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'Who will be receiving care or monitoring?',
          style: AppTypography.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: LcTextField(
                label: 'Elder Name',
                controller: _controller,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              icon: const Icon(
                Icons.add_circle,
                color: Color(0xFF2E5BFF),
                size: 32,
              ),
              onPressed: _addParent,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: ListView.builder(
            itemCount: state.parentNames.length,
            itemBuilder: (context, index) {
              final name = state.parentNames[index];
              return ListTile(
                title: Text(name),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.red,
                  ),
                  onPressed: () => ref
                      .read(familyWizardProvider.notifier)
                      .removeParent(name),
                ),
              );
            },
          ),
        ),
        LcButton(
          text: state.parentNames.isEmpty ? 'Skip for now' : 'Continue',
          onPressed: () => ref.read(familyWizardProvider.notifier).nextStep(),
        ),
      ],
    );
  }
}

class _AssignCaregiverStep extends ConsumerStatefulWidget {
  const _AssignCaregiverStep({super.key});

  @override
  ConsumerState<_AssignCaregiverStep> createState() =>
      _AssignCaregiverStepState();
}

class _AssignCaregiverStepState extends ConsumerState<_AssignCaregiverStep> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(familyWizardProvider).caregiverName,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Assign a Primary Caregiver',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'Who will be primarily managing the family settings and medicines?',
          style: AppTypography.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.xl),
        LcTextField(
          label: 'Caregiver Name',
          controller: _controller,
        ),
        const Spacer(),
        LcButton(
          text: 'Continue',
          onPressed: () {
            ref
                .read(familyWizardProvider.notifier)
                .updateCaregiver(_controller.text);
            ref.read(familyWizardProvider.notifier).nextStep();
          },
        ),
      ],
    );
  }
}

class _ReviewStep extends ConsumerWidget {
  const _ReviewStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(familyWizardProvider);
    final familyState = ref.watch(familyStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Review & Create',
          style: AppTypography.headlineLarge,
        ),
        const SizedBox(height: AppSpacing.xl),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Family Name: ${state.familyName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  state.parentNames.isEmpty
                      ? 'Elders: None added yet'
                      : 'Elders: ${state.parentNames.join(', ')}',
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  state.caregiverName.isEmpty
                      ? 'Primary Caregiver: You (Owner)'
                      : 'Primary Caregiver: ${state.caregiverName}',
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        if (familyState.isLoading)
          const Center(child: CircularProgressIndicator())
        else
          LcButton(
            text: 'Finish Setup',
            onPressed: () async {
              // 1. Create family
              await ref
                  .read(familyStateProvider.notifier)
                  .createFamily(state.familyName);

              // 2. Here we would theoretically invite members.
              // For MVP, we just navigate to dashboard when complete.
              // The router will automatically detect familyId != null
              // and redirect.
              if (context.mounted) {
                ref.read(familyWizardProvider.notifier).reset();
                context.go('/dashboard');
              }
            },
          ),
      ],
    );
  }
}
