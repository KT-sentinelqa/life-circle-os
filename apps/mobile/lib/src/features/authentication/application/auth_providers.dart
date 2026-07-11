import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/infrastructure/isar_provider.dart';
import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/authentication/application/auth_service.dart';
import 'package:lifecircle_mobile/src/features/authentication/infrastructure/session_repository.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return SessionRepository(isar);
});

final authServiceProvider = Provider<AuthService>((ref) {
  final sessionRepository = ref.watch(sessionRepositoryProvider);
  final clock = ref.watch(trustedClockProvider);
  return AuthService(sessionRepository, clock);
});

/// Exposes the current AuthState
final authStateProvider = StateProvider<AuthState>((ref) {
  return ref.watch(authServiceProvider).currentState;
});

/// Exposes the current user ID if unlocked
final currentUserIdProvider = Provider<String?>((ref) {
  final state = ref.watch(authStateProvider);
  if (state == AuthState.unlocked) {
    // In a real app, we'd fetch this from the active Session in Isar
    return 'user-default';
  }
  return null;
});
