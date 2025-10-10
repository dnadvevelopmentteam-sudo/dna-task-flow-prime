import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

// 1. Data Model for a Task
class Task {
  final String taskName;
  final String client;
  final String priority;
  final Color priorityColor;
  final String status;
  final String dueDate;
  final Color dueColor;
  final String assignee;
  final String progress;
  final bool isOverdue;

  Task({
    required this.taskName,
    required this.client,
    required this.priority,
    required this.priorityColor,
    required this.status,
    required this.dueDate,
    required this.dueColor,
    required this.assignee,
    required this.progress,
    required this.isOverdue,
  });
}

class ListBoardLayout extends StatelessWidget {
  final List<Task> tasks = List.generate(
    8,
    (index) => Task(
      taskName: 'Bank Reconciliation March',
      client: 'Green Energy Solutions',
      priority: 'Medium',
      priorityColor: const Color(0xFFFEEA80),
      status: 'Completed',
      dueDate: 'Overdue 50d 1h',
      dueColor: const Color(0xFFE57373),
      assignee: 'Anjali Patel',
      progress: '4h',
      isOverdue: true,
    ),
  );

  ListBoardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return
    //  Column(
    // children: [
    // const TaskHeaderRow(),
    // const Divider(height: 1, color: Colors.grey),
    Expanded(
      child: ListView.separated(
        itemCount: tasks.length,

        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskListItem(task: task, isHighlighted: index == 1);
        },
      ),
    );
    // ],
    // );
  }
}

// 3. Custom Widget for Each Task Row
class TaskListItem extends StatelessWidget {
  final Task task;
  final bool isHighlighted;

  static final Color _overdueRowColor = const Color(
    0xFFFFEBEE,
  ).withOpacity(0.9);
  static const Color _yellowishColor = Color(0xFFFFEDD4);

  const TaskListItem({
    super.key,
    required this.task,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color rowBackgroundColor = task.isOverdue
        ? _overdueRowColor
        : Colors.white;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: rowBackgroundColor,
        borderRadius: BorderRadius.circular(16.0),

        boxShadow: null,

        border: const Border(
          bottom: BorderSide(color: Colors.black12, width: 0.5),
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  task.taskName,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFF101828),
                    fontWeight: FontWeight.w500,
                    fontSize: context.scaleFont(16),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  task.client,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A5565),
                    fontSize: context.scaleFont(14),
                  ),
                ),
              ],
            ),
          ),

          _buildTag(task.priority, const Color(0xFFFFEDD4)),
          const SizedBox(width: 8.0),

          _buildTag(task.status, const Color(0xFFC8E6C9)),
          const SizedBox(width: 8.0),

          // Due Date Tag (Overdue)
          _buildTag(
            task.dueDate,
            task.dueColor.withOpacity(0.2),
            icon: Icons.access_time,
            iconColor: task.dueColor,
            textColor: task.dueColor,
          ),
          const SizedBox(width: 8.0),

          // 2. Assignee (Now includes person icon)
          SizedBox(
            width: 80, // Fixed width for alignment
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.person, // <-- ADDED PERSON ICON
                  size: 16.0,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4.0),
                Expanded(
                  child: Text(
                    task.assignee,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),

          // Progress Circle (Clock Icon + Time)
          Row(
            children: [
              const Icon(
                Icons.watch_later_outlined,
                size: 16.0,
                color: Colors.grey,
              ),
              const SizedBox(width: 4.0),
              Text(task.progress, style: const TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to create the styled tags/labels
  Widget _buildTag(
    String text,
    Color backgroundColor, {
    IconData? icon,
    Color? iconColor,
    Color? textColor,
  }) {
    final bool isBordered = backgroundColor == _yellowishColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),

        border: isBordered
            ? Border.all(color: Colors.grey.shade300, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Icon(icon, size: 14.0, color: iconColor),
            ),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// Taskheader row

class TaskHeaderRow extends StatelessWidget {
  const TaskHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    // The header row uses a Padding and Row layout to align with the list items.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              // Task and Client columns are combined into one Expanded section
              // in the list item, so we use one label "Task" here (or keep "Task" as the first word)
              const Expanded(
                flex: 3,
                child: Text(
                  'Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),

              // The subsequent columns need to align exactly with the tags/data in the list items.

              // Client: This is usually part of the expanded section in task boards.
              // We'll skip a dedicated "Client" header to match the typical single-column task structure.
              _buildHeaderTitle('Priority'),
              const SizedBox(width: 8.0),

              _buildHeaderTitle('Status'),
              const SizedBox(width: 8.0),

              _buildHeaderTitle('Due Date'),
              const SizedBox(width: 8.0),

              // Assignees column needs a fixed width (80) to align with the TaskListItem's Assignee SizedBox
              _buildHeaderTitle(
                'Assignees',
                width: 80,
                alignment: TextAlign.right,
              ),
              const SizedBox(width: 16.0),

              // Progress column
              _buildHeaderTitle('Progress'),
            ],
          ),
          // Add a divider below the header to separate it from the list
          const Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }

  // Helper method to create consistently styled header titles
  Widget _buildHeaderTitle(
    String title, {
    double? width,
    TextAlign alignment = TextAlign.left,
  }) {
    return SizedBox(
      width: width, // Use fixed width for Assignees
      child: Text(
        title,
        textAlign: alignment,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
