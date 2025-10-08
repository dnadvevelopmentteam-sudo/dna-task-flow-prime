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

// 2. Main Widget to Display the List
class ListBoardLayout extends StatelessWidget {
  // Static list of tasks based on the image data
  final List<Task> tasks = List.generate(
    8, // 8 rows in the image
    (index) => Task(
      taskName: 'Bank Reconciliation March',
      client: 'Green Energy Solutions',
      priority: 'Medium',
      priorityColor: const Color(0xFFFEEA80), // Yellowish
      status: 'Completed',
      dueDate: 'Overdue 50d 1h',
      dueColor: const Color(0xFFE57373), // Reddish
      assignee: 'Anjali Patel',
      progress: '4h',
      isOverdue: true,
    ),
  );

  ListBoardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List UI'),
        backgroundColor: Colors.pink[50],
        elevation: 0,
      ),
      body: Container(
        // Set the background color to match the overall light pink
        color: Colors.pink[50],
        child: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: 8.0), // Space between rows
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskListItem(
              task: task,
              isHighlighted: index == 1,
            ); // Highlight the second item
          },
        ),
      ),
    );
  }
}

// 3. Custom Widget for Each Task Row
class TaskListItem extends StatelessWidget {
  final Task task;
  final bool isHighlighted;

  const TaskListItem({
    super.key,
    required this.task,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    // The main container for the row
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.0),
        // Overdue light pink background and shadow
        boxShadow: task.isOverdue
            ? [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ]
            : null,
        border: isHighlighted
            ? Border.all(color: Colors.blue, width: 2.0) // Highlighted border
            : null,
      ),

      // The row's main content
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Task Name Column (Expanded to take most space)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4.0),
                Text(
                  task.client,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                ),
              ],
            ),
          ),

          // Priority Tag
          _buildTag(task.priority, task.priorityColor, isBordered: true),
          const SizedBox(width: 8.0),

          // Status Tag
          _buildTag(task.status, const Color(0xFFC8E6C9)), // Light Green
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

          // Assignee
          SizedBox(
            width: 80, // Fixed width for alignment
            child: Text(
              task.assignee,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
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
              Text(task.progress),
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
    bool isBordered = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.0),
        border: isBordered ? Border.all(color: Colors.grey.shade300) : null,
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
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: textColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
