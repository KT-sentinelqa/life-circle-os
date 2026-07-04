import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:lifecircle_mobile/src/design_system/widgets/lc_scaffold.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_list_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/today_reminders_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/widgets/empty_medicine_state.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/widgets/medicine_list.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/widgets/today_medications_view.dart';

/// The main dashboard for the Medicine Module.
class MedicineDashboardScreen extends ConsumerWidget {
  /// Creates a [MedicineDashboardScreen].
  const MedicineDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medicinesAsync = ref.watch(medicineListStateProvider);
    final todayRemindersAsync = ref.watch(todayRemindersProvider);

    return DefaultTabController(
      length: 2,
      child: LcScaffold(
        appBar: AppBar(
          title: const Text('Medications'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Today'),
              Tab(text: 'All Medications'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => context.push('/medicine/form'),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Tab 1: Today
            todayRemindersAsync.when(
              data: (reminders) => RefreshIndicator(
                onRefresh: () async {
                  await ref.read(todayRemindersProvider.notifier).refresh();
                },
                child: TodayMedicationsView(reminders: reminders),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Text("Failed to load today's schedule: $err"),
              ),
            ),
            // Tab 2: All Medications
            medicinesAsync.when(
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
          ],
        ),
      ),
    );
  }
}
