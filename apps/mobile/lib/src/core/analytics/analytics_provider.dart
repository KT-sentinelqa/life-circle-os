import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/analytics/analytics_service.dart';

// In a real implementation, this would read from the user's Privacy Settings in Isar/SharedPreferences.
final analyticsOptOutProvider = Provider<bool>((ref) => false);

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  final isOptedOut = ref.watch(analyticsOptOutProvider);
  return AnalyticsService(isOptedOut: isOptedOut);
});
