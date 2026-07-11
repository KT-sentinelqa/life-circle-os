import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/auth_stage.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/session.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/repositories/auth_repository.dart';

import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/features/authentication/data/repositories/production_auth_repository.dart';

/// Provider exposing the [AuthRepository] implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return ProductionAuthRepository(storage, Dio());
});

/// Offline-first implementation of [AuthRepository] using secure storage.
class LocalAuthRepository implements AuthRepository {
  /// Creates a [LocalAuthRepository].
  const LocalAuthRepository(this._storage);

  final SecureStorageService _storage;
  static const _userKey = 'current_user';
  static const _sessionKey = 'current_session';

  @override
  Future<void> requestOtp({required String identifier}) async {
    // Simulate network delay for OTP request
    await Future<void>.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<User> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    // Simulate network delay for OTP verification
    await Future<void>.delayed(const Duration(milliseconds: 1000));

    if (otp != '123456') {
      throw Exception('Invalid OTP');
    }

    final isPhone = RegExp(r'^\+?[0-9]+$').hasMatch(identifier);
    
    final user = User(
      id: 'usr_otp_123',
      name: identifier.split('@').first,
      email: isPhone ? null : identifier,
      phoneNumber: isPhone ? identifier : null,
      authStage: AuthStage.awaitingTwoFactor,
    );

    final session = Session(
      accessToken: 'mock_access_token_otp',
      refreshToken: 'mock_refresh_token_otp',
      expiry: DateTime.now().add(const Duration(days: 7)),
    );

    await _persistState(user, session);
    return user;
  }

  @override
  Future<User> setupTwoFactor({required String method}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final currentUser = await checkSession();
    if (currentUser == null) throw Exception('No active session');

    final updatedUser = currentUser.copyWith(authStage: AuthStage.awaitingDeviceTrust);
    await _storage.write(_userKey, jsonEncode(updatedUser.toJson()));
    return updatedUser;
  }

  @override
  Future<User> registerDevice({required String deviceName}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final currentUser = await checkSession();
    if (currentUser == null) throw Exception('No active session');

    final updatedUser = currentUser.copyWith(authStage: AuthStage.awaitingBiometrics);
    await _storage.write(_userKey, jsonEncode(updatedUser.toJson()));
    return updatedUser;
  }

  @override
  Future<User> setupBiometric() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final currentUser = await checkSession();
    if (currentUser == null) throw Exception('No active session');

    final updatedUser = currentUser.copyWith(authStage: AuthStage.awaitingRecoveryCodes);
    await _storage.write(_userKey, jsonEncode(updatedUser.toJson()));
    return updatedUser;
  }

  @override
  Future<User> completeAuthPipeline() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final currentUser = await checkSession();
    if (currentUser == null) throw Exception('No active session');

    final updatedUser = currentUser.copyWith(authStage: AuthStage.completed);
    await _storage.write(_userKey, jsonEncode(updatedUser.toJson()));
    return updatedUser;
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
  Future<User> forceDemoLogin(User user) async {
    final session = Session(
      accessToken: 'demo_access_token',
      refreshToken: 'demo_refresh_token',
      expiry: DateTime.now().add(const Duration(days: 365)),
    );
    await _persistState(user, session);
    return user;
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
