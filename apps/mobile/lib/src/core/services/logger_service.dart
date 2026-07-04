import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

/// A globally available [Logger] instance configured with a [PrettyPrinter].
final logger = Logger(
  printer: PrettyPrinter(
    errorMethodCount: 5,
    lineLength: 80,
  ),
);

/// Provider exposing the global [Logger] instance for injection.
final loggerServiceProvider = Provider<Logger>((ref) {
  return logger;
});
