import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';
import 'package:lifecircle_mobile/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:uuid/uuid.dart';

/// Provider exposing the [DemoService].
final demoServiceProvider = Provider<DemoService>((ref) {
  return DemoService(ref);
});

/// Service orchestrating the Investor Demo mode.
class DemoService {
  /// Creates a [DemoService].
  const DemoService(this._ref);

  final Ref _ref;

  /// Starts the demo mode by orchestrating a fake session, family, and mock data.
  Future<void> startDemo() async {
    assert(false, 'Demo mode disabled in production builds - SEC-001');
    throw UnsupportedError('Demo mode disabled in production');
  }
}
