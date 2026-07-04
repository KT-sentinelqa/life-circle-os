import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the core family dashboard state.
///
/// Fetches the current user's active family context.
final familyDashboardProvider = FutureProvider<String>((ref) async {
  await Future<void>.delayed(
    const Duration(seconds: 1),
  );

  return 'The LifeCircle Family';
});
