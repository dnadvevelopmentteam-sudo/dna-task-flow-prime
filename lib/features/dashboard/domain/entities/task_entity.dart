import 'package:flutter/material.dart';

class TaskEntity {
  final String id; // Added ID for reliable identification during move
  final String title;
  final String company;
  final String priority;
  final Color priorityColor;
  final String overdue;
  final String loggedTime;
  final int assignees;
  final String statusLabel; // e.g., 'ToDo', 'Doing', 'Done', 'Review TM'

  const TaskEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.priority,
    required this.priorityColor,
    required this.overdue,
    required this.loggedTime,
    required this.assignees,
    required this.statusLabel,
  });

  // Helper function to create a copy of the Task with a new status
  TaskEntity copyWith({String? statusLabel}) {
    return TaskEntity(
      id: id,
      title: title,
      company: company,
      priority: priority,
      priorityColor: priorityColor,
      overdue: overdue,
      loggedTime: loggedTime,
      assignees: assignees,
      statusLabel: statusLabel ?? this.statusLabel,
    );
  }
}
