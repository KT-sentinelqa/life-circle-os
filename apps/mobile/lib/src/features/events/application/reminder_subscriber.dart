import 'dart:async';
import 'package:lifecircle_mobile/src/features/events/domain/event_bus.dart';
import 'package:lifecircle_mobile/src/features/finance/domain/events/finance_events.dart';

class ReminderSubscriber {
  ReminderSubscriber({required this.eventBus}) {
    _subscription = eventBus.on<DomainEvent>().listen(_handleEvent);
  }

  final DomainEventBus eventBus;
  late final StreamSubscription _subscription;

  Future<void> _handleEvent(DomainEvent event) async {
    // In a real implementation, this would queue a payload to the Notification Engine
    // or APNS/FCM. For now, it simply intercepts relevant finance events.
    
    if (event is BillCreated) {
      // Simulate queuing a notification for the bill due date
      print('ReminderSubscriber: Queuing notification for Bill ${event.billName} (Amount: ${event.amount})');
    }
    
    if (event is InsuranceExpired) {
      // Simulate queuing an urgent renewal notification
      print('ReminderSubscriber: Urgent notification for expired policy ${event.policyName}');
    }
  }

  void dispose() {
    _subscription.cancel();
  }
}
