/// LifeCircle OS — AuthLocalDatasource: SQLite read/write operations.
///
/// Provides insert-or-replace semantics for offline resilience:
/// if a record already exists it is overwritten, preserving the latest
/// local state until the next sync cycle.
///
/// All methods accept a [Database] parameter to allow injection during
/// testing with [sqflite_ffi] in-memory databases.
///
/// Governed by: docs/mobile-architecture.md | LC-S1-006
library;

import 'package:sqflite/sqflite.dart';

import '../models/family_local_model.dart';
import '../models/user_local_model.dart';

/// Data source for local [users_local] and [families_local] SQLite tables.
class AuthLocalDatasource {
  const AuthLocalDatasource(this._db);

  final Database _db;

  // ── Users ──────────────────────────────────────────────────────────────────

  /// Insert or replace a user record in [users_local].
  ///
  /// Uses [ConflictAlgorithm.replace] to overwrite on duplicate primary key.
  Future<void> saveUser(UserLocalModel user) async {
    await _db.insert(
      'users_local',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieve a user by [id], returning null if not found.
  Future<UserLocalModel?> getUser(String id) async {
    final rows = await _db.query(
      'users_local',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserLocalModel.fromMap(rows.first);
  }

  /// Retrieve a user by [email], returning null if not found.
  Future<UserLocalModel?> getUserByEmail(String email) async {
    final rows = await _db.query(
      'users_local',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return UserLocalModel.fromMap(rows.first);
  }

  /// Update the JWT token and verified status after successful server sync.
  Future<void> updateUserToken({
    required String id,
    required String jwtToken,
    required bool isVerified,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await _db.update(
      'users_local',
      {
        'jwt_token':   jwtToken,
        'is_verified': isVerified ? 1 : 0,
        'synced_at':   now,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete all user records (used in logout / test teardown).
  Future<void> clearUsers() async {
    await _db.delete('users_local');
  }

  // ── Families ───────────────────────────────────────────────────────────────

  /// Insert or replace a family record in [families_local].
  Future<void> saveFamily(FamilyLocalModel family) async {
    await _db.insert(
      'families_local',
      family.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Retrieve a family by [id], returning null if not found.
  Future<FamilyLocalModel?> getFamily(String id) async {
    final rows = await _db.query(
      'families_local',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return FamilyLocalModel.fromMap(rows.first);
  }

  /// Retrieve all families owned by [ownerId].
  Future<List<FamilyLocalModel>> getFamiliesByOwner(String ownerId) async {
    final rows = await _db.query(
      'families_local',
      where: 'owner_id = ?',
      whereArgs: [ownerId],
      orderBy: 'created_at ASC',
    );
    return rows.map(FamilyLocalModel.fromMap).toList();
  }

  /// Delete all family records (used in test teardown).
  Future<void> clearFamilies() async {
    await _db.delete('families_local');
  }
}
