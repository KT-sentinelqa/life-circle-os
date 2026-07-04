import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/network/client/dio_api_client.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/authentication_exception.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}
class FakeOptions extends Fake implements Options {}

void main() {
  late MockDio mockDio;
  late DioApiClient apiClient;

  setUp(() {
    mockDio = MockDio();
    apiClient = DioApiClient(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions());
    registerFallbackValue(FakeOptions());
  });

  test('get() successful request', () async {
    final response = Response<Map<String, dynamic>>(
      requestOptions: RequestOptions(path: '/test'),
      data: <String, dynamic>{'success': true},
    );
    
    when(
      () => mockDio.get<Map<String, dynamic>>(
        any<String>(),
        queryParameters: any<Map<String, dynamic>>(named: 'queryParameters'),
        options: any<Options>(named: 'options'),
      ),
    ).thenAnswer((_) async => response);

    final result = await apiClient.get<Map<String, dynamic>>('/test');
    expect(result['success'], isTrue);
  });

  test('get() throws AuthenticationException on 401', () async {
    when(
      () => mockDio.get<dynamic>(
        any<String>(),
        queryParameters: any<Map<String, dynamic>>(named: 'queryParameters'),
        options: any<Options>(named: 'options'),
      ),
    ).thenThrow(
      DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response<dynamic>(
          requestOptions: RequestOptions(), 
          statusCode: 401,
        ),
      ),
    );

    expect(
      () => apiClient.get<dynamic>('/test'), 
      throwsA(isA<AuthenticationException>()),
    );
  });
}
