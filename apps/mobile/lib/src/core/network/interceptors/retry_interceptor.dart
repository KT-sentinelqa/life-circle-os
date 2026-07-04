import 'package:dio/dio.dart';
import 'package:lifecircle_mobile/src/core/network/policies/exponential_backoff_strategy.dart';
import 'package:lifecircle_mobile/src/core/network/policies/retry_policy.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryPolicy retryPolicy;
  final ExponentialBackoffStrategy backoffStrategy;

  RetryInterceptor({
    required this.dio,
    this.retryPolicy = const RetryPolicy(),
    this.backoffStrategy = const ExponentialBackoffStrategy(),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    var attempt = err.requestOptions.extra['retryAttempt'] as int? ?? 0;
    
    if (retryPolicy.shouldRetry(err, attempt)) {
      attempt++;
      err.requestOptions.extra['retryAttempt'] = attempt;
      
      final delay = backoffStrategy.getDelayForAttempt(attempt);
      await Future.delayed(delay);

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return super.onError(e, handler);
      }
    }
    
    super.onError(err, handler);
  }
}
