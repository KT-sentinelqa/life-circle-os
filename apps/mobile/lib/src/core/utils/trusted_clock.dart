import 'package:flutter_riverpod/flutter_riverpod.dart';

final trustedClockProvider =
    Provider<TrustedClock>((ref) => SystemTrustedClock());

/// Abstraction over raw DateTime.now() to prevent time manipulation
/// and allow deterministic testing.
abstract class TrustedClock {
  DateTime now();
}

/// The production implementation.
/// In Phase 4.4 (Cloud Sync), this will fetch trusted NTP time.
/// For now, it wraps the system clock but provides an interception point.
class SystemTrustedClock implements TrustedClock {
  @override
  DateTime now() => DateTime.now();
}
