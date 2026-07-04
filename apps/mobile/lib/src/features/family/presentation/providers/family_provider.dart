import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lifecircle_mobile/src/features/family/domain/entities/family_entity.dart';
import 'package:lifecircle_mobile/src/features/family/data/repositories/local_family_repository.dart';

part 'family_provider.g.dart';

@riverpod
class FamilyState extends _$FamilyState {
  @override
  AsyncValue<FamilyEntity?> build() {
    return const AsyncValue.data(null);
  }

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
