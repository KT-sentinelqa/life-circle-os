import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/auth_interceptor.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';
import 'package:mocktail/mocktail.dart';

class MockSecureStorage extends Mock implements SecureStorageService {}
class MockRequestInterceptorHandler extends Mock 
    implements RequestInterceptorHandler {}

void main() {
  test('AuthInterceptor adds token if present', () async {
    final storage = MockSecureStorage();
    final handler = MockRequestInterceptorHandler();
    final interceptor = AuthInterceptor(storage);
    
    when(() => storage.read('auth_token'))
        .thenAnswer((_) async => 'fake-token');
    
    final options = RequestOptions(path: '/');
    await interceptor.onRequest(options, handler);
    
    expect(options.headers['Authorization'], 'Bearer fake-token');
    verify(() => handler.next(options)).called(1);
  });
}
