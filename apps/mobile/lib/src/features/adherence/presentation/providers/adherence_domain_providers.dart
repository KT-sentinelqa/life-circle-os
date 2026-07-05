import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/services/adherence_calculator.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/services/missed_dose_analyzer.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/services/streak_engine.dart';
import 'package:lifecircle_mobile/src/features/adherence/domain/services/weekly_insights_service.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';

/// Provides the AdherenceCalculator.
final adherenceCalculatorProvider = Provider<AdherenceCalculator>((ref) {
  return const AdherenceCalculator();
});

/// Provides the MissedDoseAnalyzer.
final missedDoseAnalyzerProvider = Provider<MissedDoseAnalyzer>((ref) {
  return const MissedDoseAnalyzer();
});

/// Provides the StreakEngine.
final streakEngineProvider = Provider<StreakEngine>((ref) {
  final clock = ref.watch(appClockProvider);
  return StreakEngine(nowProvider: () => clock.now().toUtc());
});

/// Provides the WeeklyInsightsService.
final weeklyInsightsServiceProvider = Provider<WeeklyInsightsService>((ref) {
  return const WeeklyInsightsService();
});
