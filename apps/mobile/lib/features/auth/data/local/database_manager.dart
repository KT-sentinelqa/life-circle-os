/// LifeCircle OS — SQLite database manager (singleton).
///
/// Initialises the local SQLite database on first access, applies schema
/// migrations on upgrade, and exposes the [database] instance for use by
/// data-source classes.
///
/// Usage:
/// ```dart
/// final db = await DatabaseManager.instance.database;
/// ```
///
/// Governed by: docs/mobile-architecture.md | docs/coding-standards.md
library;

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'auth_local_schema.dart';

/// Singleton database manager for local SQLite storage.
class DatabaseManager {
  DatabaseManager._();

  /// The single shared instance.
  static final DatabaseManager instance = DatabaseManager._();

  Database? _database;

  /// Returns the initialised [Database], opening it on first access.
  Future<Database> get database async {
    _database ??= await _open();
    return _database!;
  }

  /// Closes the database and clears the cached instance.
  ///
  /// Call this in tests or during logout to release resources.
  Future<void> close() async {
    await _database?.close();
    _database = null;
  }

  // ── Private ────────────────────────────────────────────────────────────────

  Future<Database> _open() async {
    final dbPath = p.join(await getDatabasesPath(), 'lifecircle_local.db');
    return openDatabase(
      dbPath,
      version: kSchemaVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      // Enable WAL mode for better concurrent read performance.
      onOpen: (db) async => db.execute('PRAGMA journal_mode=WAL;'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    batch.execute(kCreateUsersLocalTable);
    batch.execute(kCreateFamiliesLocalTable);
    batch.execute(kCreateSyncOutboxTable);
    await batch.commit(noResult: true);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Future migrations will be applied here with conditional blocks.
    // Example:
    //   if (oldVersion < 2) { await db.execute('ALTER TABLE ...'); }
    // See: docs/golden-path/database-change.md
  }
}
