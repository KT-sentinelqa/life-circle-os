import 'package:lifecircle_mobile/src/features/family/data/repositories/local_family_repository.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_provider.g.dart';

/// State notifier for the active family.
@riverpod
class FamilyState extends _$FamilyState {
  @override
  AsyncValue<FamilyEntity?> build() {
    return const AsyncValue.data(null);
  }

  /// Creates a family and updates the state.
  Future<void> createFamily(String name) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(familyRepositoryProvider);
      final family = await repository.createFamily(name);
      state = AsyncValue.data(family);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Invites a member to the active family.
  Future<void> inviteMember(String email) async {
    final currentFamily = state.value;
    if (currentFamily == null) {
      throw StateError('Cannot invite member without an active family');
    }
    
    try {
      final repository = ref.read(familyRepositoryProvider);
      await repository.inviteMember(currentFamily.id, email);
    } catch (e) {
      rethrow;
    }
  }
}
