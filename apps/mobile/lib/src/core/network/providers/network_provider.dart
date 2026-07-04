import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/network/client/api_client.dart';
import 'package:lifecircle_mobile/src/core/network/client/dio_api_client.dart';
import 'package:lifecircle_mobile/src/core/network/config/api_config.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/auth_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/offline_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/retry_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/telemetry_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/logging_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/services/telemetry_service.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';

class DummyTelemetryService implements TelemetryService {
  @override
  void trackRequest(String method, String path, Duration duration, int statusCode) {}
  @override
  void trackFailure(String operation, Object error) {}
}

final telemetryServiceProvider = Provider<TelemetryService>((ref) {
  return DummyTelemetryService();
});

final apiConfigProvider = Provider<ApiConfig>((ref) {
  return ApiConfig.fromEnv();
});

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(apiConfigProvider);
  final secureStorage = ref.watch(secureStorageProvider);
  final telemetry = ref.watch(telemetryServiceProvider);
  
  final dio = Dio(BaseOptions(
    baseUrl: config.baseUrl,
    connectTimeout: config.timeout,
    receiveTimeout: config.timeout,
  ));

  // RULE-032: Immutable Interceptor Ordering
  dio.interceptors.add(AuthInterceptor(secureStorage));
  dio.interceptors.add(OfflineInterceptor(Connectivity()));
  dio.interceptors.add(RetryInterceptor(dio: dio));
  dio.interceptors.add(TelemetryInterceptor(telemetry));
  dio.interceptors.add(loggingInterceptor);

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return DioApiClient(dio);
});
