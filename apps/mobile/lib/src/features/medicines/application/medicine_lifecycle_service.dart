import 'package:lifecircle_mobile/src/features/medicines/domain/aggregates/medicine_aggregate.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/events/medicine_events.dart';
import 'package:lifecircle_mobile/src/features/medicines/domain/repositories/medicine_repository.dart';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';

class MedicineLifecycleService {
  const MedicineLifecycleService({
    required this.medicineRepository,
    required this.eventBus,
  });

  final MedicineRepository medicineRepository;
  final DomainEventBus eventBus;

  Future<void> dispatch(
    ({MedicineAggregate aggregate, List<MedicineEvent> events}) result
  ) async {
    // 1. Persist local projection
    await medicineRepository.save(result.aggregate);

    // 2. Publish to the Domain Event Bus
    // The OutboxSubscriber and TimelineSubscriber will intercept this asynchronously.
    for (final event in result.events) {
      await eventBus.publish(event);
    }
  }
}
