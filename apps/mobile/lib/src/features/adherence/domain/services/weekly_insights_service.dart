import 'package:lifecircle_mobile/src/features/adherence/domain/entities/adherence_metrics.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/entities/medicine_log_entity.dart';

/// Generates insights and nudges based on adherence patterns.
class WeeklyInsightsService {
  /// Creates a [WeeklyInsightsService].
  const WeeklyInsightsService();

  /// Generates a brief text insight for the dashboard.
  String generateInsight({
    required AdherenceMetrics metrics,
    required List<MedicineLogEntity> recentLogs,
  }) {
    if (metrics.streak >= 7) {
      return 'Incredible! You are on a ${metrics.streak}-day perfect '
          'streak. Keep it up! 🚀';
    }

    if (metrics.adherencePercentage >= 0.9) {
      return 'Great job this week! You are staying right on track. 🌟';
    }

    if (metrics.adherencePercentage <= 0.5 && metrics.totalDosesScheduled > 0) {
      return 'It looks like you missed a few doses recently. '
          'Need help setting better reminders?';
    }

    return 'Consistency is key. You got this! 💪';
  }
}
