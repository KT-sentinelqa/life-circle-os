import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_list_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/widgets/empty_medicine_state.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/widgets/medicine_list.dart';

/// The main dashboard for the Medicine Module.
class MedicineDashboardScreen extends ConsumerWidget {
  /// Creates a [MedicineDashboardScreen].
  const MedicineDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicinesAsync = ref.watch(medicineListStateProvider);

    return LcScaffold(
      appBar: AppBar(
        title: const Text('Medications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/medicine/form'),
          ),
        ],
      ),
      body: medicinesAsync.when(
        data: (medicines) {
          if (medicines.isEmpty) {
            return EmptyMedicineState(
              onAddPressed: () => context.push('/medicine/form'),
            );
          }
          return RefreshIndicator(
            onRefresh: () {
              return ref.read(medicineListStateProvider.notifier).refresh();
            },
            child: MedicineList(
              medicines: medicines,
              onMedicineTapped: (medicine) {
                context.push('/medicine/form', extra: medicine);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Failed to load medications: $err'),
        ),
      ),
    );
  }
}
