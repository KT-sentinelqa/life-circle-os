import 'package:lifecircle_mobile/src/core/config/initial_session_provider.dart';
import 'package:lifecircle_mobile/src/features/authentication/data/repositories/local_auth_repository.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

/// Provider for managing authentication state.
@riverpod
class Auth extends _$Auth {
  @override
  AsyncValue<User?> build() {
    final initialSession = ref.watch(initialSessionProvider);
    return AsyncValue.data(initialSession);
  }

  /// Requests an OTP for the given [identifier] (email or phone).
  Future<void> requestOtp(String identifier) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      await repository.requestOtp(identifier: identifier);
      // We don't change state to Data(User) because user isn't logged in yet,
      // but we need to revert from loading state.
      // However, we just revert to the existing state (null user)
      final currentUser = state.valueOrNull;
      state = AsyncValue.data(currentUser);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Verifies the OTP for the given [identifier].
  Future<void> verifyOtp(String identifier, String otp) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.verifyOtp(identifier: identifier, otp: otp);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Configures two-factor authentication and advances state.
  Future<void> setupTwoFactor(String method) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.setupTwoFactor(method: method);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Registers the current device as trusted and advances state.
  Future<void> registerDevice(String deviceName) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.registerDevice(deviceName: deviceName);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Configures biometric unlock and advances state.
  Future<void> setupBiometric() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.setupBiometric();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Completes the authentication pipeline.
  Future<void> completeAuthPipeline() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.completeAuthPipeline();
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
