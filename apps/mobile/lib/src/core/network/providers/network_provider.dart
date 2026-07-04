import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lifecircle_mobile/src/core/network/client/api_client.dart';
import 'package:lifecircle_mobile/src/core/network/client/dio_api_client.dart';
import 'package:lifecircle_mobile/src/core/network/config/api_config.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/auth_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/logging_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/offline_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/retry_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/telemetry_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/services/telemetry_service.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';

/// Dummy telemetry service for bootstrapping.
class DummyTelemetryService implements TelemetryService {
  /// Creates a [DummyTelemetryService].
  const DummyTelemetryService();

  @override
  void trackRequest(
    String method,
    String path,
    Duration duration,
    int statusCode,
  ) {}
  
  @override
  void trackFailure(String operation, Object error) {}
}

/// Provider for the [TelemetryService].
final telemetryServiceProvider = Provider<TelemetryService>((ref) {
  return const DummyTelemetryService();
});

/// Provider for the [ApiConfig].
final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig.fromEnv();
});

/// Provider for the [Dio] instance.
final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(apiConfigProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final telemetry = ref.watch(telemetryServiceProvider);
  
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: config.timeout,
      receiveTimeout: config.timeout,
    ),
  );

  // RULE-032: Immutable Interceptor Ordering
  dio.interceptors.add(AuthInterceptor(secureStorage));
  dio.interceptors.add(OfflineInterceptor(Connectivity()));
  dio.interceptors.add(RetryInterceptor(dio: dio));
  dio.interceptors.add(TelemetryInterceptor(telemetry));
  dio.interceptors.add(loggingInterceptor);

  return dio;
});

/// Provider for the [ApiClient].
final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return DioApiClient(dio);
});
