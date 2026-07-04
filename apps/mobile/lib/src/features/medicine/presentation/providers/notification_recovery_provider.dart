import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/core/notifications/providers/notification_provider.dart';
import 'package:lifecircle_mobile/src/features/medicine/domain/services/notification_recovery_service.dart';
import 'package:lifecircle_mobile/src/features/medicine/presentation/providers/medicine_provider.dart';

/// Provider for the Notification Recovery Service.
final notificationRecoveryServiceProvider =
    Provider<NotificationRecoveryService>((ref) {
  return NotificationRecoveryService(
    notificationService: ref.watch(notificationServiceProvider),
    medicineRepository: ref.watch(medicineRepositoryProvider),
  );
});
