import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'package:lifecircle_mobile/src/core/network/exceptions/offline_exception.dart';

/// Interceptor that checks network connectivity before making a request.
class OfflineInterceptor extends Interceptor {
  /// Creates an [OfflineInterceptor].
  OfflineInterceptor(this.connectivity);

  /// Connectivity instance for checking network status.
  final Connectivity connectivity;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await connectivity.checkConnectivity();
    
    if (connectivityResult.isEmpty || 
        connectivityResult.every((r) => r == ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const OfflineException(),
          type: DioExceptionType.connectionError,
        ),
      );
    }
    
    handler.next(options);
  }
}
