import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_metrics.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_domain_providers.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_repository_provider.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/medicine_streak_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'adherence_metrics_provider.g.dart';

/// Provides adherence metrics for the last 30 days.
@riverpod
Future<AdherenceMetrics?> adherenceMetrics(
  AdherenceMetricsRef ref, {
  String? medicineId,
}) async {
  final user = ref.watch(authProvider).valueOrNull;
  if (user == null || user.familyId == null) {
    return null;
  }

  final repository = ref.watch(adherenceRepositoryProvider);
  final clock = ref.watch(appClockProvider);

  final endDate = clock.now().toUtc();
  final startDate = endDate.subtract(const Duration(days: 30));

  final records = await repository.getAdherenceRecords(
    user.familyId!,
    user.id,
    startDateUtc: startDate,
    endDateUtc: endDate,
    medicineId: medicineId,
  );

  final streak = await ref.watch(
    medicineStreakProvider(medicineId: medicineId).future,
  );
  final currentStreak = streak?.currentStreak ?? 0;

  final calculator = ref.watch(adherenceCalculatorProvider);
  return calculator.calculateMetrics(records, currentStreak: currentStreak);
}
