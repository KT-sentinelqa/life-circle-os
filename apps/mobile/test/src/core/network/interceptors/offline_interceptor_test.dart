import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/offline_exception.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/offline_interceptor.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}
class MockRequestInterceptorHandler extends Mock 
    implements RequestInterceptorHandler {}

void main() {
  setUpAll(() {
    registerFallbackValue(DioException(requestOptions: RequestOptions()));
  });

  test('OfflineInterceptor rejects when disconnected', () async {
    final connectivity = MockConnectivity();
    final handler = MockRequestInterceptorHandler();
    final interceptor = OfflineInterceptor(connectivity);
    
    when(connectivity.checkConnectivity)
        .thenAnswer((_) async => <ConnectivityResult>[ConnectivityResult.none]);
    
    final options = RequestOptions(path: '/');
    await interceptor.onRequest(options, handler);
    
    final captured = verify(() => handler.reject(captureAny<DioException>()))
        .captured;
    final exception = captured.first as DioException;
    expect(exception.error, isA<OfflineException>());
  });
}
