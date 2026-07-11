import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/repositories/auth_repository.dart';

/// Production implementation of [AuthRepository] interacting with the real backend.
/// SEC-001: Networking operations currently throw UnimplementedError until the
/// backend contract is finalized, explicitly preventing mock bypasses.
class ProductionAuthRepository implements AuthRepository {
  /// Creates a [ProductionAuthRepository].
  const ProductionAuthRepository(this._storage, this._dio);

  final SecureStorageService _storage;
  // ignore: unused_field
  final Dio _dio;

  static const _userKey = 'current_user';
  static const _sessionKey = 'current_session';

  @override
  Future<void> requestOtp({required String identifier}) async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
  }

  @override
  Future<User> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
  }

  @override
  Future<User> setupTwoFactor({required String method}) async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
  }

  @override
  Future<User> registerDevice({required String deviceName}) async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
  }

  @override
  Future<User> setupBiometric() async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
  }

  @override
  Future<User> completeAuthPipeline() async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
  }

  @override
  Future<User> createFamily({required String familyName}) async {
    throw UnsupportedError('Backend contract not finalized - SEC-001');
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
}
