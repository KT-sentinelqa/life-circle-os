import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/infrastructure/isar_provider.dart';
import 'package:lifecircle_mobile/src/features/emergency/domain/models/emergency_contact.dart';
import 'package:lifecircle_mobile/src/features/emergency/infrastructure/repositories/emergency_contact_repository.dart';

final emergencyContactRepositoryProvider =
    Provider<EmergencyContactRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return IsarEmergencyContactRepository(isar);
});

/// Reactive stream of emergency contacts for a given household.
/// Rebuilds the Emergency Screen automatically on any Isar write.
final emergencyContactsStreamProvider =
    StreamProvider.family<List<EmergencyContact>, String>(
        (ref, householdId) async* {
  final isar = ref.watch(isarProvider);
  final repository = ref.watch(emergencyContactRepositoryProvider);

  // Emit initial state
  yield await repository.getAllContacts(householdId);

  // Yield new state whenever the emergencyContacts collection changes
  await for (final _ in isar.emergencyContacts.watchLazy()) {
    yield await repository.getAllContacts(householdId);
  }
});
