import 'package:dio/dio.dart';

import 'package:lifecircle_mobile/src/core/network/services/telemetry_service.dart';

/// Interceptor that tracks request durations and failures.
class TelemetryInterceptor extends Interceptor {
  /// Creates a [TelemetryInterceptor].
  TelemetryInterceptor(this.telemetryService);

  /// The telemetry service used for tracking.
  final TelemetryService telemetryService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _track(response.requestOptions, response.statusCode ?? 200);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _track(err.requestOptions, err.response?.statusCode ?? 0);
    telemetryService.trackFailure(err.requestOptions.path, err);
    handler.next(err);
  }

  void _track(RequestOptions options, int statusCode) {
    final startTime = options.extra['startTime'] as int?;
    final duration = startTime != null
        ? Duration(
            milliseconds: DateTime.now().millisecondsSinceEpoch - startTime,
          )
        : Duration.zero;

    telemetryService.trackRequest(
      options.method,
      options.path,
      duration,
      statusCode,
    );
  }
}
