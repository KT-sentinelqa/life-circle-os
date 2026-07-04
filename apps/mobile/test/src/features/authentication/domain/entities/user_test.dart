import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/src/features/authentication/domain/entities/user.dart';

void main() {
  group('User Entity', () {
    test('supports value equality', () {
      const user1 = User(id: '1', name: 'John', email: 'john@example.com');
      const user2 = User(id: '1', name: 'John', email: 'john@example.com');
      const user3 = User(id: '2', name: 'Jane', email: 'jane@example.com');

      expect(user1, equals(user2));
      expect(user1, isNot(equals(user3)));
    });

    test('can be created from JSON and serialized to JSON', () {
      final json = {
        'id': '1',
        'name': 'John',
        'email': 'john@example.com',
        'familyId': 'fam_1',
      };

      final user = User.fromJson(json);

      expect(user.id, '1');
      expect(user.name, 'John');
      expect(user.email, 'john@example.com');
      expect(user.familyId, 'fam_1');
      
      expect(user.toJson(), equals(json));
    });
  });
}
