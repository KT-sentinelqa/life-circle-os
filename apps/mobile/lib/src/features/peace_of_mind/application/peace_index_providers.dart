import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/infrastructure/isar_provider.dart';
import '../../../../core/utils/trusted_clock.dart';
import '../../responsibilities/domain/models/family_responsibility.dart';
import 'peace_index_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Milestone 3: Reactive Peace Index using Isar's watchLazy stream.
//
// Architecture:
//   Isar.watchLazy(familyResponsibilitys)   ← fires on ANY Isar write
//     ↓
//   Fetch all responsibilities
//     ↓
//   PeaceIndexService.calculateContextualIndex()
//     ↓
//   StreamProvider emits updated score
//     ↓
//   DashboardScreen rebuilds automatically — NO manual refresh.
// ─────────────────────────────────────────────────────────────────────────────

final trustedClockProvider = Provider<TrustedClock>((ref) => TrustedClock());

final peaceIndexServiceProvider = Provider<PeaceIndexService>((ref) {
  final clock = ref.watch(trustedClockProvider);
  return PeaceIndexService(clock);
});

/// Reactive Peace Score — emits a new int every time Isar responsibilities change.
/// The Dashboard and any other consumer rebuild automatically.
final peaceIndexStreamProvider =
    StreamProvider.family<int, String>((ref, currentUserId) async* {
  final isar  = ref.watch(isarProvider);
  final service = ref.watch(peaceIndexServiceProvider);

  // Emit the first value immediately
  final initial = await isar.familyResponsibilitys.where().findAll();
  yield service.calculateContextualIndex(currentUserId, initial);

  // Then emit every time any responsibility changes
  await for (final _ in isar.familyResponsibilitys.watchLazy()) {
    final updated = await isar.familyResponsibilitys.where().findAll();
    yield service.calculateContextualIndex(currentUserId, updated);
  }
});

/// Non-reactive FutureProvider — kept for compatibility with existing consumers.
/// New code should prefer peaceIndexStreamProvider.
final peaceIndexProvider = Provider.family<int, String>((ref, currentUserId) {
  final responsibilitiesAsync = ref.watch(familyResponsibilitiesStreamProvider);
  final service = ref.watch(peaceIndexServiceProvider);

  return responsibilitiesAsync.maybeWhen(
    data: (responsibilities) =>
        service.calculateContextualIndex(currentUserId, responsibilities),
    orElse: () => 100, // Optimistic default
  );
});

/// Stream of all responsibilities — drives both the list screen and the score.
final familyResponsibilitiesStreamProvider =
    StreamProvider<List<FamilyResponsibility>>((ref) async* {
  final isar = ref.watch(isarProvider);

  yield await isar.familyResponsibilitys.where().findAll();

  await for (final _ in isar.familyResponsibilitys.watchLazy()) {
    yield await isar.familyResponsibilitys.where().findAll();
  }
});
