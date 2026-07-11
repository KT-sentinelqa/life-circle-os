import 'dart:async';

abstract class DomainEvent {
  String get eventId;
  String get aggregateId;
  DateTime get timestamp;
  Map<String, dynamic> toJson();
}

abstract class DomainEventBus {
  Future<void> publish(DomainEvent event);
  Stream<T> on<T extends DomainEvent>();
}

class InMemoryDomainEventBus implements DomainEventBus {
  final _controller = StreamController<DomainEvent>.broadcast();

  @override
  Future<void> publish(DomainEvent event) async {
    _controller.add(event);
  }

  @override
  Stream<T> on<T extends DomainEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  void dispose() {
    _controller.close();
  }
}
