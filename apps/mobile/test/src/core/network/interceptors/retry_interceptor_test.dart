import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/network/policies/retry_policy.dart';

void main() {
  test('RetryPolicy deterministic behavior', () {
    final policy = const RetryPolicy();
    final err500 = DioException(
      requestOptions: RequestOptions(path: '/'),
      response: Response(requestOptions: RequestOptions(path: ''), statusCode: 500),
    );
    final err401 = DioException(
      requestOptions: RequestOptions(path: '/'),
      response: Response(requestOptions: RequestOptions(path: ''), statusCode: 401),
    );

    expect(policy.shouldRetry(err500, 0), isTrue); // Retry 500
    expect(policy.shouldRetry(err500, 3), isFalse); // Max attempts reached
    expect(policy.shouldRetry(err401, 0), isFalse); // Never retry 401
  });
}
