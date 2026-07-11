import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/feature_flags/models/feature_flag.dart';

class FeatureFlagService {
  FeatureFlagService(this._isar, this._currentCohort);
  final Isar _isar;
  // In a real implementation, we would inject a user/context service to check cohorts.
  final String _currentCohort;

  /// Checks if a feature flag is enabled.
  /// ADR-038: Offline-first. If a flag isn't found locally, it defaults to false.
  Future<bool> isEnabled(String key) async {
    final flag = await _isar.featureFlags.where().keyEqualTo(key).findFirst();

    if (flag == null) return false;
    if (!flag.isEnabled) return false;

    // Cohort targeting check
    if (flag.targetCohort != null && flag.targetCohort!.isNotEmpty) {
      return flag.targetCohort == _currentCohort;
    }

    return true; // Globally enabled
  }

  /// Evaluates multiple flags synchronously (useful for UI rendering if flags are pre-loaded).
  /// In Riverpod, we typically stream the list of all flags and evaluate in-memory.
  bool isEnabledSync(List<FeatureFlag> allFlags, String key) {
    final flag = allFlags.where((f) => f.key == key).firstOrNull;
    if (flag == null || !flag.isEnabled) return false;

    if (flag.targetCohort != null && flag.targetCohort!.isNotEmpty) {
      return flag.targetCohort == _currentCohort;
    }
    return true;
  }
}
