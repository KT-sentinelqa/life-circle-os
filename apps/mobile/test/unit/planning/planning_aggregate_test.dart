import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/priority.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/task_status.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/aggregates/task_aggregate.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/events/planning_events.dart';

void main() {
  group('Phase 3B Sprint 6: Task Aggregate', () {
    test('Creating a task yields TaskCreated event', () {
      final init = TaskAggregate.initialize('hh_1');

      final result = init.aggregate.createTask(
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        title: 'Renew Passport',
        description: 'Need to submit forms',
        priority: Priority.high,
      );

      expect(result.aggregate.tasks.length, 1);
      expect(result.aggregate.tasks.first.status, TaskStatus.todo);
      expect(result.events.length, 1);
      expect(result.events.first, isA<TaskCreated>());
    });

    test('Completing a task makes it immutable', () {
      final init = TaskAggregate.initialize('hh_1');

      final created = init.aggregate.createTask(
        ownerId: 'mem_1',
        ownerName: 'Krishna',
        title: 'Renew Passport',
        description: '',
        priority: Priority.high,
      );

      final taskId = created.aggregate.tasks.first.taskId;

      final completed = created.aggregate.completeTask(
        taskId: taskId,
        actorId: 'mem_1',
        actorName: 'Krishna',
      );

      expect(completed.aggregate.tasks.first.status, TaskStatus.completed);
      expect(completed.events.first, isA<TaskCompleted>());

      // Attempting to complete again should throw
      expect(
        () => completed.aggregate.completeTask(
          taskId: taskId,
          actorId: 'mem_1',
          actorName: 'Krishna',
        ),
        throwsA(isA<Exception>().having((e) => e.toString(), 'msg', contains('immutable'))),
      );
    });
  });
}
