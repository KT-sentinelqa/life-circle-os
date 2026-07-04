/// Strategy for applying exponential backoff between retries.
class ExponentialBackoffStrategy {
  /// Creates an [ExponentialBackoffStrategy].
  const ExponentialBackoffStrategy({
    this.backoffIntervals = const <Duration>[
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 4),
    ],
  });

  /// The predefined intervals for each backoff step.
  final List<Duration> backoffIntervals;

  /// Returns the delay duration for the current attempt.
  Duration getDelayForAttempt(int attempt) {
    if (attempt <= 0) return Duration.zero;
    if (attempt > backoffIntervals.length) {
      return backoffIntervals.last;
    }
    return backoffIntervals[attempt - 1];
  }
}
