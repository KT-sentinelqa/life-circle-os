import 'package:isar/isar.dart';
import '../../features/responsibilities/domain/models/family_responsibility.dart';
import '../../features/responsibilities/domain/models/responsibility_status.dart';
import 'utils/trusted_clock.dart';

class RetentionService {
  final Isar isar;
  final TrustedClock clock;

  RetentionService(this.isar, this.clock);

  /// Aggressively prunes old tasks to maintain Isar performance.
  /// Designed to be called by a background WorkManager daily.
  Future<void> enforceRetentionPolicy() async {
    final cutoffDate = clock.now().subtract(const Duration(days: 90));

    await isar.writeTxn(() async {
      // Find all tasks that are Completed/Verified/Skipped and older than 90 days
      final obsoleteTasks = await isar.familyResponsibilitys
          .filter()
          .anyOf([
            ResponsibilityStatus.completed,
            ResponsibilityStatus.verified,
            ResponsibilityStatus.skipped
          ], (q, status) => q.statusEqualTo(status))
          .and()
          .updatedAtLessThan(cutoffDate)
          .findAll();

      final obsoleteIds = obsoleteTasks.map((t) => t.id).toList();
      
      // Delete them to preserve local storage limits
      if (obsoleteIds.isNotEmpty) {
        await isar.familyResponsibilitys.deleteAll(obsoleteIds);
      }
    });
  }
}
