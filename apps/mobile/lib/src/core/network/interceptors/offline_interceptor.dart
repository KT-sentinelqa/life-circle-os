import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/offline_exception.dart';

class OfflineInterceptor extends Interceptor {
  final Connectivity connectivity;

  OfflineInterceptor(this.connectivity);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final connectivityResult = await connectivity.checkConnectivity();
    
    if (connectivityResult.isEmpty || connectivityResult.every((r) => r == ConnectivityResult.none)) {
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
