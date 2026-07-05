import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds transient state for the family creation wizard.
class FamilyWizardState {
  /// Creates a [FamilyWizardState].
  const FamilyWizardState({
    this.familyName = '',
    this.parentNames = const [],
    this.caregiverName = '',
    this.currentStep = 0,
  });

  /// The name of the family.
  final String familyName;

  /// List of parent names to invite.
  final List<String> parentNames;

  /// The caregiver name.
  final String caregiverName;

  /// Current step in the wizard.
  final int currentStep;

  /// Creates a copy of this state with the given fields replaced.
  FamilyWizardState copyWith({
    String? familyName,
    List<String>? parentNames,
    String? caregiverName,
    int? currentStep,
  }) {
    return FamilyWizardState(
      familyName: familyName ?? this.familyName,
      parentNames: parentNames ?? this.parentNames,
      caregiverName: caregiverName ?? this.caregiverName,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}

/// Notifier for managing [FamilyWizardState].
class FamilyWizardNotifier extends Notifier<FamilyWizardState> {
  @override
  FamilyWizardState build() => const FamilyWizardState();

  /// Advances to the next step.
  void nextStep() => state = state.copyWith(currentStep: state.currentStep + 1);

  /// Goes back to the previous step.
  void prevStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  /// Resets the wizard.
  void reset() => state = const FamilyWizardState();

  /// Updates the family name.
  void updateFamilyName(String name) =>
      state = state.copyWith(familyName: name);

  /// Adds a parent name.
  void addParent(String name) {
    if (name.isNotEmpty && !state.parentNames.contains(name)) {
      state = state.copyWith(parentNames: [...state.parentNames, name]);
    }
  }

  /// Removes a parent name.
  void removeParent(String name) {
    state = state.copyWith(
      parentNames: state.parentNames.where((n) => n != name).toList(),
    );
  }

  /// Updates the caregiver name.
  void updateCaregiver(String name) =>
      state = state.copyWith(caregiverName: name);
}

/// Provider for the family creation wizard state.
final familyWizardProvider =
    NotifierProvider<FamilyWizardNotifier, FamilyWizardState>(
  FamilyWizardNotifier.new,
);
