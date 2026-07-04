import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Provider for the [DatabaseService]. Must be overridden at bootstrap.
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('databaseServiceProvider is not initialized');
});

/// Manages the Isar database lifecycle.
class DatabaseService {
  const DatabaseService._(this._isar);

  final Isar _isar;

  /// Exposes the active Isar instance.
  Isar get db => _isar;

  /// Initializes the Isar database.
  /// Provide schemas to Isar.open.
  static Future<DatabaseService> init(
    List<CollectionSchema<dynamic>> schemas,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      schemas,
      directory: dir.path,
    );
    return DatabaseService._(isar);
  }
}
