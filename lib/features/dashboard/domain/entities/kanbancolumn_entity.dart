import 'package:flutter/material.dart';

import 'task_entity.dart';

class KanbanColumnEntity {
  final String title;
  final String status;
  final List<TaskEntity> tasks;
  final Color color;

  const KanbanColumnEntity({
    required this.title,
    required this.status,
    required this.tasks,
    required this.color,
  });

  // Helper to create a copy of the column with a new list of tasks
  KanbanColumnEntity copyWith({List<TaskEntity>? tasks}) {
    return KanbanColumnEntity(
      title: title,
      status: status,
      tasks: tasks ?? this.tasks,
      color: color,
    );
  }
}