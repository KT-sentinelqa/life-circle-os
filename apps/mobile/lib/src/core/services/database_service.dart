import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Provides local database access utilizing Isar.
class DatabaseService {
  /// Creates a new [DatabaseService] instance.
  DatabaseService(this.isar);

  /// The underlying [Isar] database instance.
  final Isar isar;
}

/// Asynchronously initializes and provides the [DatabaseService].
final databaseServiceProvider = FutureProvider<DatabaseService>((ref) async {
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [],
    directory: dir.path,
  );

  return DatabaseService(isar);
});
