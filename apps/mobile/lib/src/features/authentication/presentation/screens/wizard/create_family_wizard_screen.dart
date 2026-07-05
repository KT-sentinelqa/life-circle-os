import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_shared_axis_switcher.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_text_field.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/family_wizard_provider.dart';
import 'package:lifecircle_mobile/src/features/family/presentation/providers/family_provider.dart';

/// Orchestrates the multi-step family creation flow.
class CreateFamilyWizardScreen extends ConsumerStatefulWidget {
  /// Creates a [CreateFamilyWizardScreen].
  const CreateFamilyWizardScreen({super.key});

  @override
  ConsumerState<CreateFamilyWizardScreen> createState() =>
      _CreateFamilyWizardScreenState();
}

class _CreateFamilyWizardScreenState
    extends ConsumerState<CreateFamilyWizardScreen> {
  int _previousStep = 0;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(familyWizardProvider);
    final notifier = ref.read(familyWizardProvider.notifier);

    // Track direction for shared axis
    final isReverse = state.currentStep < _previousStep;
    _previousStep = state.currentStep;

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Create Family'),
        leading: state.currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  notifier.prevStep();
                },
              )
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  notifier.reset();
                  context.pop();
                },
              ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              // Progress Bar
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                tween: Tween<double>(
                  begin: 0,
                  end: (state.currentStep + 1) / 4.0,
                ),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    color: const Color(0xFF2E5BFF),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(AppSpacing.xs),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: LcSharedAxisSwitcher(
                  reverse: isReverse,
                  child: _buildStepContent(context, ref, state),
                ),
              ),
            ],
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

class _ReviewStep extends ConsumerStatefulWidget {
  const _ReviewStep({super.key});

  @override
  ConsumerState<_ReviewStep> createState() => _ReviewStepState();
}

class _ReviewStepState extends ConsumerState<_ReviewStep> {
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
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
                  'Added Members:',
                  style: AppTypography.bodyLarge
                      .copyWith(fontWeight: FontWeight.bold),
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
        else if (_isSuccess)
          Center(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
                  ),
                );
              },
            ),
          )
        else
          LcButton(
            text: 'Finish Setup',
            onPressed: () async {
              final startTime = DateTime.now();

              await ref
                  .read(familyStateProvider.notifier)
                  .createFamily(state.familyName);

              final elapsed = DateTime.now().difference(startTime);
              if (elapsed.inMilliseconds < 400) {
                await Future<void>.delayed(
                  Duration(milliseconds: 400 - elapsed.inMilliseconds),
                );
              }

              if (context.mounted) {
                setState(() => _isSuccess = true);
                await Future<void>.delayed(const Duration(milliseconds: 600));

                if (context.mounted) {
                  ref.read(familyWizardProvider.notifier).reset();
                  context.go('/dashboard');
                }
              }
            },
          ),
      ],
    );
  }
}
