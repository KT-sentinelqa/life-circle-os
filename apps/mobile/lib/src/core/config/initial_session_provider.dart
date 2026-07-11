import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';

/// Provides the synchronously pre-loaded user session at application startup.
///
/// This provider must be overridden in a [ProviderScope] with the actual
/// session fetched during the app bootstrap phase before the router is built.
final initialSessionProvider = Provider<User?>((ref) {
  throw UnimplementedError('initialSessionProvider must be overridden in ProviderScope');
});
