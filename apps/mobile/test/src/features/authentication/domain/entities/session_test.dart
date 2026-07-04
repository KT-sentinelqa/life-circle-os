import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/features/authentication/domain/entities/session.dart';

void main() {
  group('Session Entity', () {
    test('supports value equality', () {
      final date = DateTime.now();
      final session1 = Session(
        accessToken: 'a',
        refreshToken: 'b',
        expiry: date,
      );
      final session2 = Session(
        accessToken: 'a',
        refreshToken: 'b',
        expiry: date,
      );
      final session3 = Session(
        accessToken: 'c',
        refreshToken: 'd',
        expiry: date,
      );

      expect(session1, equals(session2));
      expect(session1, isNot(equals(session3)));
    });

    test('can be created from JSON and serialized to JSON', () {
      final date = DateTime.utc(2025).toIso8601String();
      final json = {
        'accessToken': 'a',
        'refreshToken': 'b',
        'expiry': date,
      };

      final session = Session.fromJson(json);

      expect(session.accessToken, 'a');
      expect(session.refreshToken, 'b');
      expect(session.expiry, DateTime.parse(date));
      
      expect(session.toJson(), equals(json));
    });
  });
}
