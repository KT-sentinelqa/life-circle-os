import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/storage/database_service.dart';

void main() {
  group('DatabaseService', () {
    test('databaseServiceProvider throws UnimplementedError if not overridden',
        () {
      final container = ProviderContainer();
      expect(
        () => container.read(databaseServiceProvider),
        throwsUnimplementedError,
      );
    });
  });
}
