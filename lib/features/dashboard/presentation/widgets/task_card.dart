import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final bool isDragging;
  final bool isPlaceholder;

  const TaskCard({
    super.key,
    required this.task,
    this.isDragging = false,
    this.isPlaceholder = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the task's current status for the card background
    Color cardBgColor = Colors.white;
    if (task.statusLabel == 'ToDo') {
      cardBgColor = Colors.red.shade50;
    } else if (task.statusLabel == 'Doing') {
      cardBgColor = Colors.yellow.shade50;
    } else if (task.statusLabel == 'Done') {
      cardBgColor = Colors.green.shade50;
    } else if (task.statusLabel == 'Review TM') {
      cardBgColor = Colors.blue.shade50;
    }

    // Adjust card style if it's currently the feedback widget
    double elevation = isDragging ? 8.0 : 0.0;
    Color borderColor = isPlaceholder
        ? Colors.transparent
        : const Color(0xFFEEEEEE);

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor, width: 1),
      ),
      color: cardBgColor, // Card background color
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Title and Priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: task.priorityColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    task.priority,
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Row 2: Company Name
            Text(
              task.company,
              style: TextStyle(
                fontSize: context.scaleFont(12),
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 12),
            // Row 3: Overdue Info
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: context.scaleFont(14),
                  color: Colors.red.shade700,
                ),
                const SizedBox(width: 4),
                Text(
                  task.overdue,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.timer_outlined,
                  size: context.scaleFont(14),
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 4),
                Text(
                  task.loggedTime,
                  style: TextStyle(
                    fontSize: context.scaleFont(12),
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            // Row 4: Status and Assignees
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Assignees (Placeholder)
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: context.scaleFont(14),
                      color: Colors.grey.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${task.assignees} assignee${task.assignees == 1 ? '' : 's'}',
                      style: TextStyle(
                        fontSize: context.scaleFont(12),
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                // Status Label (using task.statusLabel from the data)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: task
                        .priorityColor, // Re-using priority color for status chip
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.statusLabel,
                    style: TextStyle(
                      fontSize: context.scaleFont(10),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
