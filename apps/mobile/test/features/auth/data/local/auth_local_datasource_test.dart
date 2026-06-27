/// LifeCircle OS — AuthLocalDatasource unit tests.
///
/// Uses sqflite_ffi with an in-memory database — no physical device required.
/// All tests are deterministic and isolated.
///
/// Run: flutter test test/features/auth/data/local/auth_local_datasource_test.dart
///
/// Governed by: docs/testing-pipeline.md | LC-S1-006 DoD
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:lifecircle_mobile/features/auth/data/local/auth_local_datasource.dart';
import 'package:lifecircle_mobile/features/auth/data/local/auth_local_schema.dart';
import 'package:lifecircle_mobile/features/auth/data/models/family_local_model.dart';
import 'package:lifecircle_mobile/features/auth/data/models/user_local_model.dart';

void main() {
  // Initialise sqflite_ffi for in-memory testing
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late Database db;
  late AuthLocalDatasource datasource;

  setUp(() async {
    db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: kSchemaVersion,
        onCreate: (d, _) async {
          await d.execute(kCreateUsersLocalTable);
          await d.execute(kCreateFamiliesLocalTable);
          await d.execute(kCreateSyncOutboxTable);
        },
      ),
    );
    datasource = AuthLocalDatasource(db);
  });

  tearDown(() async => db.close());

  // ── User Tests ─────────────────────────────────────────────────────────────

  group('AuthLocalDatasource — users', () {
    const testUser = UserLocalModel(
      id: 'user-001',
      email: 'guardian@example.com',
      fullName: 'Krishna Tiwari',
      role: 'guardian',
      createdAt: 1719403200000,
    );

    test('saves and retrieves a user by id', () async {
      await datasource.saveUser(testUser);
      final found = await datasource.getUser('user-001');

      expect(found, isNotNull);
      expect(found!.id, equals('user-001'));
      expect(found.email, equals('guardian@example.com'));
      expect(found.fullName, equals('Krishna Tiwari'));
      expect(found.role, equals('guardian'));
      expect(found.isVerified, isFalse);
    });

    test('saves and retrieves a user by email', () async {
      await datasource.saveUser(testUser);
      final found = await datasource.getUserByEmail('guardian@example.com');

      expect(found, isNotNull);
      expect(found!.id, equals('user-001'));
    });

    test('returns null for unknown user id', () async {
      final found = await datasource.getUser('nonexistent-id');
      expect(found, isNull);
    });

    test('replace-on-conflict updates existing user', () async {
      await datasource.saveUser(testUser);

      // Save same id with different fullName — must replace
      const updated = UserLocalModel(
        id: 'user-001',
        email: 'guardian@example.com',
        fullName: 'Krishna R. Tiwari',
        role: 'guardian',
        createdAt: 1719403200000,
      );
      await datasource.saveUser(updated);

      final found = await datasource.getUser('user-001');
      expect(found!.fullName, equals('Krishna R. Tiwari'));
    });

    test('updates jwt_token and synced_at', () async {
      await datasource.saveUser(testUser);
      await datasource.updateUserToken(
        id: 'user-001',
        jwtToken: 'eyJhbGciOiJIUzI1NiJ9.test.token',
        isVerified: true,
      );

      final found = await datasource.getUser('user-001');
      expect(found!.jwtToken, equals('eyJhbGciOiJIUzI1NiJ9.test.token'));
      expect(found.isVerified, isTrue);
      expect(found.syncedAt, isNotNull);
    });

    test('clearUsers removes all records', () async {
      await datasource.saveUser(testUser);
      await datasource.clearUsers();
      final found = await datasource.getUser('user-001');
      expect(found, isNull);
    });
  });

  // ── Family Tests ───────────────────────────────────────────────────────────

  group('AuthLocalDatasource — families', () {
    const testFamily = FamilyLocalModel(
      id: 'family-001',
      name: 'Tiwari Family',
      ownerId: 'user-001',
      createdAt: 1719403200000,
    );

    test('saves and retrieves a family by id', () async {
      await datasource.saveFamily(testFamily);
      final found = await datasource.getFamily('family-001');

      expect(found, isNotNull);
      expect(found!.id, equals('family-001'));
      expect(found.name, equals('Tiwari Family'));
      expect(found.ownerId, equals('user-001'));
    });

    test('returns null for unknown family id', () async {
      final found = await datasource.getFamily('nonexistent-id');
      expect(found, isNull);
    });

    test('retrieves all families by owner', () async {
      await datasource.saveFamily(testFamily);
      await datasource.saveFamily(
        const FamilyLocalModel(
          id: 'family-002',
          name: 'Second Family',
          ownerId: 'user-001',
          createdAt: 1719403201000,
        ),
      );
      // Different owner — must not appear
      await datasource.saveFamily(
        const FamilyLocalModel(
          id: 'family-003',
          name: 'Other Family',
          ownerId: 'user-002',
          createdAt: 1719403202000,
        ),
      );

      final families = await datasource.getFamiliesByOwner('user-001');
      expect(families.length, equals(2));
      expect(families.map((f) => f.id), containsAll(['family-001', 'family-002']));
    });

    test('replace-on-conflict updates family name', () async {
      await datasource.saveFamily(testFamily);
      const renamed = FamilyLocalModel(
        id: 'family-001',
        name: 'Tiwari Extended Family',
        ownerId: 'user-001',
        createdAt: 1719403200000,
      );
      await datasource.saveFamily(renamed);

      final found = await datasource.getFamily('family-001');
      expect(found!.name, equals('Tiwari Extended Family'));
    });
  });
}
