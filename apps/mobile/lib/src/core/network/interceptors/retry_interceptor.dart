import 'package:dio/dio.dart';

import 'package:lifecircle_mobile/src/core/network/policies/exponential_backoff_strategy.dart';
import 'package:lifecircle_mobile/src/core/network/policies/retry_policy.dart';

/// Interceptor that retries failed requests based on a policy.
class RetryInterceptor extends Interceptor {
  /// Creates a [RetryInterceptor].
  RetryInterceptor({
    required this.dio,
    this.retryPolicy = const RetryPolicy(),
    this.backoffStrategy = const ExponentialBackoffStrategy(),
  });

  /// The Dio instance used for retrying requests.
  final Dio dio;

  /// The policy determining whether a retry is allowed.
  final RetryPolicy retryPolicy;

  /// The strategy for calculating delays between retries.
  final ExponentialBackoffStrategy backoffStrategy;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    var attempt = err.requestOptions.extra['retryAttempt'] as int? ?? 0;

    if (retryPolicy.shouldRetry(err, attempt)) {
      attempt++;
      err.requestOptions.extra['retryAttempt'] = attempt;

      final delay = backoffStrategy.getDelayForAttempt(attempt);
      await Future<void>.delayed(delay);

      try {
        final response = await dio.fetch<dynamic>(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return super.onError(e, handler);
      }
    }

    super.onError(err, handler);
  }
}
