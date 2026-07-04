import 'package:flutter/material.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/design_system/widgets/lc_button.dart';

/// Widget displayed when the user has no medications.
class EmptyMedicineState extends StatelessWidget {
  /// Creates an [EmptyMedicineState].
  const EmptyMedicineState({
    required this.onAddPressed,
    super.key,
  });

  /// Callback when the add button is pressed.
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.medical_services_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'No Medications Yet',
            style: AppTypography.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Keep track of your prescriptions, schedules, and adherence by '
            'adding your first medication.',
            style: AppTypography.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          LcButton(
            text: 'Add Medication',
            onPressed: onAddPressed,
          ),
        ],
      ),
    );
  }
}
