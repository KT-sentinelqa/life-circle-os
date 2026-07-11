import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:lifecircle_mobile/src/core/feature_flags/feature_flag_service.dart';
import 'package:lifecircle_mobile/src/core/feature_flags/models/feature_flag.dart';
import 'package:lifecircle_mobile/src/core/infrastructure/isar_provider.dart';

// Dummy provider for cohort, normally provided by Auth/Identity module
final currentUserCohortProvider = Provider<String>((ref) => 'beta_testers');

final featureFlagServiceProvider = Provider<FeatureFlagService>((ref) {
  final isar = ref.watch(isarProvider);
  final cohort = ref.watch(currentUserCohortProvider);
  return FeatureFlagService(isar, cohort);
});

/// Reactive stream of all feature flags in the local Isar database.
final featureFlagsStreamProvider =
    StreamProvider<List<FeatureFlag>>((ref) async* {
  final isar = ref.watch(isarProvider);

  yield await isar.featureFlags.where().findAll();

  await for (final _ in isar.featureFlags.watchLazy()) {
    yield await isar.featureFlags.where().findAll();
  }
});

/// A specific provider to evaluate a single flag reactively.
/// Usage: `final isEnabled = ref.watch(flagEnabledProvider('emergency_killswitch'));`
final flagEnabledProvider = Provider.family<bool, String>((ref, flagKey) {
  final flagsAsync = ref.watch(featureFlagsStreamProvider);
  final service = ref.watch(featureFlagServiceProvider);

  return flagsAsync.maybeWhen(
    data: (flags) => service.isEnabledSync(flags, flagKey),
    orElse: () => false, // Fail closed for safety
  );
});
