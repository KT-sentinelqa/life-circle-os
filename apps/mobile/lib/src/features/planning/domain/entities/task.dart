import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/priority.dart';
import 'package:lifecircle_mobile/src/features/planning/domain/value_objects/task_status.dart';

@immutable
class Task {
  Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    this.assigneeId,
  }) : taskId = const Uuid().v4();

  const Task._({
    required this.taskId,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    this.assigneeId,
  });

  final String taskId;
  final String title;
  final String description;
  final Priority priority;
  final TaskStatus status;
  final String? assigneeId;

  Task copyWith({
    String? title,
    String? description,
    Priority? priority,
    TaskStatus? status,
    String? assigneeId,
  }) {
    return Task._(
      taskId: taskId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      assigneeId: assigneeId ?? this.assigneeId,
    );
  }
}
