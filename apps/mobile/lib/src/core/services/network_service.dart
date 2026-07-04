import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile/src/core/services/logger_service.dart';
import 'package:mobile/src/core/services/storage_service.dart';

/// Provides a pre-configured [Dio] client for making HTTP requests.
///
/// This client automatically attaches the authorization token to requests
/// and logs request/response/error details.
final networkServiceProvider = Provider<Dio>((ref) {
  final storage = ref.watch(storageServiceProvider);
  final log = ref.watch(loggerServiceProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8000/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read('access_token');

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        log.d('REQUEST ${options.method} ${options.path}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        log.d(
          'RESPONSE ${response.statusCode} ${response.requestOptions.path}',
        );

        handler.next(response);
      },
      onError: (error, handler) {
        log.e(
          'ERROR ${error.response?.statusCode} ${error.requestOptions.path}',
        );

        handler.next(error);
      },
    ),
  );

  return dio;
});
