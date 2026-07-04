import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/session.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/repositories/auth_repository.dart';

/// Provider exposing the [AuthRepository] implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return LocalAuthRepository(storage);
});

/// Offline-first implementation of [AuthRepository] using secure storage.
class LocalAuthRepository implements AuthRepository {
  /// Creates a [LocalAuthRepository].
  const LocalAuthRepository(this._storage);

  final SecureStorageService _storage;
  static const _userKey = 'current_user';
  static const _sessionKey = 'current_session';

  @override
  Future<User> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    
    if (password != 'password') {
      throw Exception('Invalid credentials');
    }

    final user = User(
      id: 'usr_123',
      name: 'Test User',
      email: email,
    );
    
    final session = Session(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      expiry: DateTime.now().add(const Duration(days: 7)),
    );

    await _persistState(user, session);
    return user;
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    
    final user = User(
      id: 'usr_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
    );
    
    final session = Session(
      accessToken: 'mock_access_token',
      refreshToken: 'mock_refresh_token',
      expiry: DateTime.now().add(const Duration(days: 7)),
    );

    await _persistState(user, session);
    return user;
  }

  @override
  Future<User> createFamily({required String familyName}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    final currentUser = await checkSession();
    if (currentUser == null) throw Exception('No active session');

    final updatedUser = currentUser.copyWith(
      familyId: 'fam_${DateTime.now().millisecondsSinceEpoch}',
    );
    
    await _storage.write(_userKey, jsonEncode(updatedUser.toJson()));
    return updatedUser;
  }

  @override
  Future<void> logout() async {
    await _storage.delete(_userKey);
    await _storage.delete(_sessionKey);
  }

  @override
  Future<User?> checkSession() async {
    final userJson = await _storage.read(_userKey);
    final sessionJson = await _storage.read(_sessionKey);

    if (userJson != null && sessionJson != null) {
      return User.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> _persistState(User user, Session session) async {
    await _storage.write(_userKey, jsonEncode(user.toJson()));
    await _storage.write(_sessionKey, jsonEncode(session.toJson()));
  }
}
