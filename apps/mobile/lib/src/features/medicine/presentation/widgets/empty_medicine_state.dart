import 'package:flutter/material.dart';
import 'package:lifecircle_mobile/src/features/shared/presentation/widgets/lc_empty_state.dart';

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
    return LcEmptyState(
      icon: Icons.medication_outlined,
      title: 'No medicines yet',
      subtitle: 'Start by adding medicines for yourself\nor your loved ones.',
      ctaText: 'Add Medicine',
      onCtaPressed: onAddPressed,
    );
  }
}
