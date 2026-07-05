import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_record.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_repository_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'adherence_heatmap_provider.g.dart';

/// Provides historical adherence records (e.g., last 90 days) for rendering
/// the heatmap.
@riverpod
Future<List<AdherenceRecord>> adherenceHeatmap(
  AdherenceHeatmapRef ref, {
  String? medicineId,
}) async {
  final user = ref.watch(authProvider).valueOrNull;
  if (user == null || user.familyId == null) {
    return [];
  }

  final repository = ref.watch(adherenceRepositoryProvider);
  final clock = ref.watch(appClockProvider);

  final endDate = clock.now().toUtc();
  final startDate = endDate.subtract(const Duration(days: 90));

  return repository.getAdherenceRecords(
    user.familyId!,
    user.id,
    startDateUtc: startDate,
    endDateUtc: endDate,
    medicineId: medicineId,
  );
}
