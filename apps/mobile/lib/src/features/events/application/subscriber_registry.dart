import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/events/application/outbox_subscriber.dart';
import 'package:lifecircle_mobile/src/features/events/application/timeline_subscriber.dart';
import 'package:lifecircle_mobile/src/features/events/application/reminder_subscriber.dart';

class EventSubscriberRegistry {
  EventSubscriberRegistry(this.eventBus);

  final DomainEventBus eventBus;

  final List<dynamic> _subscribers = [];

  void registerAll({
    required OutboxSubscriber outboxSubscriber,
    required TimelineSubscriber timelineSubscriber,
    required ReminderSubscriber reminderSubscriber,
  }) {
    // In a production environment, this registry would wrap subscribers
    // in retry decorators or circuit breakers to enforce zero-blast-radius execution.
    _subscribers.addAll([
      outboxSubscriber,
      timelineSubscriber,
      reminderSubscriber,
    ]);
  }

  void disposeAll() {
    for (final subscriber in _subscribers) {
      // Introspection to call dispose
      try {
        (subscriber as dynamic).dispose();
      } catch (_) {}
    }
    _subscribers.clear();
  }
}
