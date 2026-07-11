import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/priority.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/task_status.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/entities/task.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/events/planning_events.dart';

@immutable
class TaskAggregate {
  const TaskAggregate._({
    required this.aggregateId,
    required this.householdId,
    required this.tasks,
  });

  final String aggregateId;
  final String householdId;
  final List<Task> tasks;

  static ({TaskAggregate aggregate, List<PlanningEvent> events}) initialize(String householdId) {
    return (
      aggregate: TaskAggregate._(
        aggregateId: const Uuid().v4(),
        householdId: householdId,
        tasks: const [],
      ),
      events: [],
    );
  }

  ({TaskAggregate aggregate, List<PlanningEvent> events}) createTask({
    required String ownerId,
    required String ownerName,
    required String title,
    required String description,
    required Priority priority,
  }) {
    final task = Task(
      title: title,
      description: description,
      priority: priority,
      status: TaskStatus.todo,
    );

    final event = TaskCreated(
      planningId: aggregateId,
      householdId: householdId,
      ownerId: ownerId,
      ownerName: ownerName,
      taskTitle: title,
    );

    return (
      aggregate: copyWith(
        tasks: List.unmodifiable([...tasks, task]),
      ),
      events: [event],
    );
  }

  ({TaskAggregate aggregate, List<PlanningEvent> events}) completeTask({
    required String taskId,
    required String actorId,
    required String actorName,
  }) {
    final taskIndex = tasks.indexWhere((t) => t.taskId == taskId);
    if (taskIndex == -1) throw Exception('Task not found');
    
    final task = tasks[taskIndex];
    if (task.status == TaskStatus.completed) {
      throw Exception('Task is already completed and immutable.');
    }
    if (task.status == TaskStatus.archived) {
      throw Exception('Cannot complete an archived task.');
    }

    final updatedTask = task.copyWith(status: TaskStatus.completed);
    final updatedTasks = List<Task>.from(tasks)..[taskIndex] = updatedTask;

    final event = TaskCompleted(
      planningId: aggregateId,
      householdId: householdId,
      actorId: actorId,
      actorName: actorName,
      taskTitle: task.title,
    );

    return (
      aggregate: copyWith(tasks: List.unmodifiable(updatedTasks)),
      events: [event],
    );
  }

  TaskAggregate copyWith({
    List<Task>? tasks,
  }) {
    return TaskAggregate._(
      aggregateId: aggregateId,
      householdId: householdId,
      tasks: tasks ?? this.tasks,
    );
  }
}
