import 'package:flutter/material.dart';

import 'package:lifecircle_mobile/src/design_system/spacing/app_spacing.dart';
import 'package:lifecircle_mobile/src/design_system/typography/app_typography.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_entity.dart';

/// Displays a list of [MedicineEntity] objects.
class MedicineList extends StatelessWidget {
  /// Creates a [MedicineList].
  const MedicineList({
    required this.medicines,
    required this.onMedicineTapped,
    super.key,
  });

  /// The list of medicines to display.
  final List<MedicineEntity> medicines;

  /// Callback when a medicine is tapped.
  final ValueChanged<MedicineEntity> onMedicineTapped;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: medicines.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: AppSpacing.sm,
      ),
      itemBuilder: (context, index) {
        final medicine = medicines[index];
        return Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            contentPadding: const EdgeInsets.all(AppSpacing.md),
            leading: const CircleAvatar(
              child: Icon(Icons.medication),
            ),
            title: Text(
              medicine.name,
              style: AppTypography.bodyLarge,
            ),
            subtitle: Text(
              medicine.instructions,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => onMedicineTapped(medicine),
          ),
        );
      },
    );
  }
}
