import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';

/// A card that highlights the most frequently missed hour.
class MissedDosePatternsCard extends ConsumerWidget {
  /// Creates a [MissedDosePatternsCard].
  const MissedDosePatternsCard({super.key, this.medicineId});

  /// The medicine ID to show patterns for, or null for global.
  final String? medicineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Currently, MedicineRepository does not expose a way to fetch
    // MedicineLogEntity list.
    // So we display a placeholder or empty state until the repository
    // method is implemented.
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Semantics(
          label: 'Missed Dose Patterns: Data unavailable.',
          excludeSemantics: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Missed Dose Patterns',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              const Text('Not enough data to determine patterns yet.'),
            ],
          ),
        ),
      ),
    );
  }
}
