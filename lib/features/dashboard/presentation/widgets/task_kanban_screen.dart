import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/kanbancolumn_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/task_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/kanban_board_layout.dart';
import 'package:flutter/material.dart';

class TaskKanbanScreen extends StatefulWidget {
  const TaskKanbanScreen({super.key});

  @override
  State<TaskKanbanScreen> createState() => _TaskKanbanScreenState();
}

class _TaskKanbanScreenState extends State<TaskKanbanScreen> {
  // State holds the mutable list of Kanban data
  late List<KanbanColumnEntity> _kanbanData;

  @override
  void initState() {
    super.initState();
    // Use a deep copy of the initial data so we can modify it
    _kanbanData = List.from(initialKanbanData);
  }

  // CORE LOGIC: Function to move a task from one column to another
  void _moveTask(TaskEntity task, String targetStatus) {
    setState(() {
      TaskEntity? taskToMove;
      String? oldStatusLabel;
      int oldColIndex = -1;

      // 1. Find and remove the task from its source column
      for (int i = 0; i < _kanbanData.length; i++) {
        final column = _kanbanData[i];
        final taskIndex = column.tasks.indexWhere((t) => t.id == task.id);

        if (taskIndex != -1) {
          // Task found in this column
          taskToMove = column.tasks[taskIndex];
          oldStatusLabel = column.title; // Use column title for status label
          oldColIndex = i;

          // Create a mutable copy of the tasks list, remove the task
          List<TaskEntity> newTasks = List.from(column.tasks);
          newTasks.removeAt(taskIndex);

          // Update the column with the new, shorter task list
          _kanbanData[i] = column.copyWith(tasks: newTasks);
          break; // Task found, stop searching
        }
      }

      // 2. Add the task to the target column
      if (taskToMove != null) {
        // Find the target column index based on the target status (e.g., 'todo', 'done')
        final targetColIndex = _kanbanData.indexWhere(
          (col) => col.status == targetStatus,
        );

        if (targetColIndex != -1) {
          // Determine the new status label (using the target column's title)
          final newStatusLabel = _kanbanData[targetColIndex].title;

          // Update the task's status label
          final updatedTask = taskToMove.copyWith(statusLabel: newStatusLabel);

          // Create a mutable copy of the target tasks list, add the updated task
          List<TaskEntity> newTasks = List.from(
            _kanbanData[targetColIndex].tasks,
          );
          newTasks.add(updatedTask);

          // Update the target column with the new, longer task list
          _kanbanData[targetColIndex] = _kanbanData[targetColIndex].copyWith(
            tasks: newTasks,
          );
        } else {
          // If the target column isn't found, revert the task back to the original column
          // (Basic error handling)
          print(
            'Error: Target column not found for status: $targetStatus. Reverting move.',
          );
          if (oldColIndex != -1) {
            List<TaskEntity> newTasks = List.from(
              _kanbanData[oldColIndex].tasks,
            );
            newTasks.add(taskToMove);
            _kanbanData[oldColIndex] = _kanbanData[oldColIndex].copyWith(
              tasks: newTasks,
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RBAC Demo Header (Omitted for brevity, assumed to be here)
          const SizedBox(height: 30),

          // Task Board Title and Controls
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Board',
                    style: TextStyle(
                      fontSize: context.scaleFont(24),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Drag and drop cards to update status.',
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              // Buttons (Omitted for brevity, assumed to be here)
            ],
          ),
          const SizedBox(height: 30),

          // Kanban Columns Grid/List - Pass the data and the move callback
          KanbanBoardLayout(columns: _kanbanData, onTaskMove: _moveTask),
        ],
      ),
    );
  }
}
