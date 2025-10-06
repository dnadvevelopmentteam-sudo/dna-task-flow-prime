import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/kanbancolumn_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/task_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/kanban_column_widget.dart';
import 'package:flutter/material.dart';

class KanbanBoardLayout extends StatelessWidget {
  final List<KanbanColumnEntity> columns;
  final Function(TaskEntity task, String targetStatus) onTaskMove;

  const KanbanBoardLayout({
    super.key,
    required this.columns,
    required this.onTaskMove,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      // Stack vertically on mobile
      return Column(
        children: columns
            .map(
              (col) => Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: KanbanColumnWidget(column: col, onTaskMove: onTaskMove),
              ),
            )
            .toList(),
      );
    } else {
      // Horizontal layout on desktop/tablet
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columns
              .map(
                (col) => Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: SizedBox(
                    width: 280, // Fixed width for each column
                    child: KanbanColumnWidget(
                      column: col,
                      onTaskMove: onTaskMove,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }
  }
}
