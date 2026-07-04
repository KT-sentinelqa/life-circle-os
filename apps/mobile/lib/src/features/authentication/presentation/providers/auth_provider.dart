import 'dart:async';
import 'package:mobile/src/features/authentication/data/repositories/local_auth_repository.dart';
import 'package:mobile/src/features/authentication/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Manages the authentication state of the application.
@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  FutureOr<User?> build() async {
    final repository = ref.read(authRepositoryProvider);
    return repository.checkSession();
  }

  /// Attempts to log the user in.
  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return repository.login(email: email, password: password);
    });
  }

  /// Attempts to register a new user.
  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return repository.register(name: name, email: email, password: password);
    });
  }

  /// Creates a family and associates it with the current user.
  Future<void> createFamily(String familyName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(authRepositoryProvider);
      return repository.createFamily(familyName: familyName);
    });
  }

  /// Logs the user out.
  Future<void> logout() async {
    state = const AsyncLoading();
    final repository = ref.read(authRepositoryProvider);
    await repository.logout();
    state = const AsyncData(null);
  }
}
