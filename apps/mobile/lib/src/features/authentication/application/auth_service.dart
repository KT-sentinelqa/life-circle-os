import 'package:lifecircle_mobile/src/core/utils/trusted_clock.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/models/session.dart';
import 'package:lifecircle_mobile/src/features/authentication/infrastructure/session_repository.dart';
import 'package:uuid/uuid.dart';

enum AuthState {
  unauthenticated,
  authenticating,
  authenticated, // But locked (needs biometric)
  unlocked, // Fully ready
}

class AuthService {
  AuthService(this._repository, this._clock);
  final SessionRepository _repository;
  final TrustedClock _clock;
  final Uuid _uuid = const Uuid();

  AuthState _currentState = AuthState.unauthenticated;
  AuthState get currentState => _currentState;

  Future<void> initialize() async {
    final session = await _repository.getActiveSession();
    if (session != null) {
      // Offline-first: if we have a valid refresh token, we start in the authenticated (locked) state.
      // Biometric unlock is required to move to unlocked.
      _currentState = AuthState.authenticated;
    } else {
      _currentState = AuthState.unauthenticated;
    }
  }

  /// Placeholder for primary authentication (e.g., Passkeys).
  Future<bool> authenticateWithPasskey() async {
    _currentState = AuthState.authenticating;
    // ... implement WebAuthn ...

    // Dummy success
    final now = _clock.now();
    final session = Session()
      ..sessionId = _uuid.v4()
      ..userId = 'dummy-user'
      ..deviceId = 'dummy-device'
      ..accessToken = 'dummy.jwt.token'
      ..accessExpiresAt = now.add(const Duration(minutes: 15))
      ..refreshTokenReference = 'keychain-ref-123'
      ..refreshExpiresAt = now.add(const Duration(days: 30))
      ..createdAt = now
      ..lastActiveAt = now;

    await _repository.saveSession(session);
    _currentState = AuthState.unlocked; // Newly authenticated is unlocked
    return true;
  }

  /// Implements SEC-026: Absolute Logout
  Future<void> logout() async {
    // 1. Invalidate remotely (call backend with refreshTokenReference)
    // 2. Clear local session repository
    await _repository.clearAllSessions();

    // 3. SEC-026 requires wiping Isar DB completely here
    // _isar.clear() in a full wipe service

    _currentState = AuthState.unauthenticated;
  }

  Future<bool> unlockWithBiometrics() async {
    if (_currentState != AuthState.authenticated) return false;

    // ... Call local_auth plugin ...
    const didAuthenticate = true; // dummy

    if (didAuthenticate) {
      _currentState = AuthState.unlocked;
    }
    return didAuthenticate;
  }
}
