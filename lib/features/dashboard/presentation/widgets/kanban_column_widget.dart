import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/kanbancolumn_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/task_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/task_card.dart';
import 'package:flutter/material.dart';

class KanbanColumnWidget extends StatefulWidget {
  final KanbanColumnEntity column;
  final Function(TaskEntity task, String targetStatus) onTaskMove;

  const KanbanColumnWidget({
    super.key,
    required this.column,
    required this.onTaskMove,
  });

  @override
  State<KanbanColumnWidget> createState() => _KanbanColumnWidgetState();
}

class _KanbanColumnWidgetState extends State<KanbanColumnWidget> {
  // State to track if a task is currently being dragged over this column
  bool isDraggingOver = false;

  @override
  Widget build(BuildContext context) {
    // 1. Wrap the entire column body in a DragTarget
    return DragTarget<TaskEntity>(
      // Determine if this target can accept the dragged data (accepts any Task)
      onWillAcceptWithDetails: (details) {
        // Prevent dropping a task onto its current column
        if (details.data.statusLabel == widget.column.title) {
          return false;
        }
        setState(() => isDraggingOver = true);
        return true;
      },
      // Reset the dragging state when the draggable leaves
      onLeave: (data) {
        setState(() => isDraggingOver = false);
      },
      // Handle the data drop when accepted
      onAcceptWithDetails: (task) {
        setState(() => isDraggingOver = false);
        // Call the external move function in the parent state
        widget.onTaskMove(task.data, widget.column.status);
      },
      builder:
          (
            BuildContext context,
            List<Object?> candidateData,
            List<dynamic> rejectedData,
          ) {
            return Container(
              decoration: BoxDecoration(
                // Change background color when dragging over
                color: isDraggingOver
                    ? widget.column.color
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      children: [
                        Text(
                          widget.column.title,
                          style: TextStyle(
                            fontSize: context.scaleFont(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.column.tasks.length.toString(),
                            style: TextStyle(
                              fontSize: context.scaleFont(12),
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Task Cards List - Now wrapped in Draggable
                  ...widget.column.tasks.map(
                    (task) => Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      // 2. TaskCard wrapped in Draggable
                      child: Draggable<TaskEntity>(
                        data: task,
                        // The widget shown at the original location while dragging
                        childWhenDragging: Opacity(
                          opacity: 0.5,
                          child: TaskCard(task: task, isPlaceholder: true),
                        ),
                        // The widget that follows the pointer during the drag
                        feedback: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: context.isMobile
                                ? context.screenWidth - 40
                                : 280,
                            child: TaskCard(task: task, isDragging: true),
                          ),
                        ),
                        child: TaskCard(task: task),
                      ),
                    ),
                  ),

                  // Add Task Button
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: context.scaleFont(20),
                        color: Colors.blue.shade700,
                      ),
                      label: Text(
                        '+ Add Task',
                        style: TextStyle(
                          fontSize: context.scaleFont(14),
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
    );
  }
}
