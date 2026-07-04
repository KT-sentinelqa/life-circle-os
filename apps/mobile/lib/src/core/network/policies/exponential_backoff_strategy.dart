class ExponentialBackoffStrategy {
  final List<Duration> backoffIntervals;

  const ExponentialBackoffStrategy({
    this.backoffIntervals = const [
      Duration(seconds: 1),
      Duration(seconds: 2),
      Duration(seconds: 4),
    ],
  });

  Duration getDelayForAttempt(int attempt) {
    if (attempt <= 0) return Duration.zero;
    if (attempt > backoffIntervals.length) {
      return backoffIntervals.last;
    }
    return backoffIntervals[attempt - 1];
  }
}
