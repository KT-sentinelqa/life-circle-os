import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:lifecircle_mobile/src/core/network/interceptors/telemetry_interceptor.dart';
import 'package:lifecircle_mobile/src/core/network/services/telemetry_service.dart';

class MockTelemetry extends Mock implements TelemetryService {}
class MockResponseInterceptorHandler extends Mock implements ResponseInterceptorHandler {}

void main() {
  setUpAll(() {
    registerFallbackValue(Duration.zero);
  });

  test('TelemetryInterceptor tracks successful requests', () {
    final telemetry = MockTelemetry();
    final handler = MockResponseInterceptorHandler();
    final interceptor = TelemetryInterceptor(telemetry);
    
    final options = RequestOptions(path: '/test', method: 'GET');
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch - 100; 
    
    final response = Response(requestOptions: options, statusCode: 200);
    interceptor.onResponse(response, handler);
    
    verify(() => telemetry.trackRequest('GET', '/test', any(), 200)).called(1);
    verify(() => handler.next(response)).called(1);
  });
}
