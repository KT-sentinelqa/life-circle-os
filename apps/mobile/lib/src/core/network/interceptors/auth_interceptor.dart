import 'package:dio/dio.dart';

import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';

/// Interceptor that appends the authentication token to requests.
class AuthInterceptor extends Interceptor {
  /// Creates an [AuthInterceptor].
  AuthInterceptor(this.secureStorage);

  /// The secure storage service to retrieve the token from.
  final SecureStorageService secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await secureStorage.read('auth_token');
    
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    handler.next(options);
  }
}
