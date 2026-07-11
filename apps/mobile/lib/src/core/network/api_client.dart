import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/features/network/infrastructure/interceptors.dart';

class ApiClient {
  ApiClient({
    required this.contextInterceptor,
    required this.signatureInterceptor,
    required this.replayProtectionInterceptor,
    required this.retryPolicyInterceptor,
    required this.telemetryInterceptor,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: 'https://api.lifecircle.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // We rely on Native SPKI Pinning (Android network_security_config / iOS Info.plist)
      // so we do NOT attach a custom Dart HttpClientAdapter that overrides trust.
    ));

    // RULE-032: Interceptor ordering is strictly immutable.
    _dio.interceptors.addAll([
      contextInterceptor,
      signatureInterceptor,
      replayProtectionInterceptor,
      retryPolicyInterceptor,
      telemetryInterceptor,
    ]);
  }

  late final Dio _dio;
  final ContextInterceptor contextInterceptor;
  final SignatureInterceptor signatureInterceptor;
  final ReplayProtectionInterceptor replayProtectionInterceptor;
  final RetryPolicyInterceptor retryPolicyInterceptor;
  final TelemetryInterceptor telemetryInterceptor;

  Dio get client => _dio;
}
