// ignore_for_file: one_member_abstracts
import 'package:clock/clock.dart';

/// Abstract interface for clock operations.
abstract interface class AppClock {
  /// Returns the current local time.
  DateTime now();
}

/// System-based implementation of [AppClock].
final class SystemClock implements AppClock {
  /// Creates a [SystemClock].
  const SystemClock();

  @override
  DateTime now() => clock.now();
}
