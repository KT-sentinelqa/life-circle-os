import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lifecircle_mobile/src/core/network/policies/retry_policy.dart';

void main() {
  test('RetryPolicy deterministic behavior', () {
    const policy = RetryPolicy();
    final err500 = DioException(
      requestOptions: RequestOptions(path: '/'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(),
        statusCode: 500,
      ),
    );
    final err401 = DioException(
      requestOptions: RequestOptions(path: '/'),
      response: Response<dynamic>(
        requestOptions: RequestOptions(),
        statusCode: 401,
      ),
    );

    expect(policy.shouldRetry(err500, 0), isTrue);
    expect(policy.shouldRetry(err500, 3), isFalse);
    expect(policy.shouldRetry(err401, 0), isFalse);
  });
}
