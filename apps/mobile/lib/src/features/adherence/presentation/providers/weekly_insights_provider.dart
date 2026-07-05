import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_domain_providers.dart';
import 'package:lifecircle_mobile/src/features/adherence/presentation/providers/adherence_metrics_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_insights_provider.g.dart';

/// Provides a weekly insight string based on recent adherence metrics.
@riverpod
Future<String?> weeklyInsights(
  WeeklyInsightsRef ref, {
  String? medicineId,
}) async {
  final metrics = await ref.watch(
    adherenceMetricsProvider(medicineId: medicineId).future,
  );
  if (metrics == null) return null;

  final insightsService = ref.watch(weeklyInsightsServiceProvider);
  return insightsService.generateInsight(
    metrics: metrics,
    recentLogs: [], // Not currently utilized by the generator
  );
}
