import 'package:lifecircle_mobile/src/features/authentication/data/repositories/local_auth_repository.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Provider for managing authentication state.
@riverpod
class Auth extends _$Auth {
  @override
  AsyncValue<User?> build() {
    _checkSession();
    return const AsyncValue.loading();
  }

  Future<void> _checkSession() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.checkSession();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Logs in the user with [email] and [password].
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(email: email, password: password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Registers a new user.
  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.register(
        name: name, 
        email: email, 
        password: password,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Creates a new family.
  Future<void> createFamily(String familyName) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.createFamily(familyName: familyName);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Logs the user out.
  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
