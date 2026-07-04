import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lifecircle_mobile/src/core/network/client/dio_api_client.dart';
import 'package:lifecircle_mobile/src/core/network/exceptions/authentication_exception.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late DioApiClient apiClient;

  setUp(() {
    mockDio = MockDio();
    apiClient = DioApiClient(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  test('get() successful request', () async {
    final response = Response(
      requestOptions: RequestOptions(path: '/test'),
      data: {'success': true},
      statusCode: 200,
    );
    
    when(() => mockDio.get<Map<String, dynamic>>(
      any(),
      queryParameters: any(named: 'queryParameters'),
      options: any(named: 'options'),
    )).thenAnswer((_) async => response);

    final result = await apiClient.get<Map<String, dynamic>>('/test');
    expect(result['success'], isTrue);
  });

  test('get() throws AuthenticationException on 401', () async {
    when(() => mockDio.get(
      any(),
      queryParameters: any(named: 'queryParameters'),
      options: any(named: 'options'),
    )).thenThrow(DioException(
      requestOptions: RequestOptions(path: '/test'),
      response: Response(requestOptions: RequestOptions(path: ''), statusCode: 401),
    ));

    expect(() => apiClient.get('/test'), throwsA(isA<AuthenticationException>()));
  });
}
