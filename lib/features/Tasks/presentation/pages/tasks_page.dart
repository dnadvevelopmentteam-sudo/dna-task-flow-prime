import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/kanbancolumn_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/task_entity.dart';
import 'package:dna_taskflow_prime/features/tasks/presentation/widgets/create_new_task_dialoug.dart';
import 'package:dna_taskflow_prime/features/tasks/presentation/widgets/kanban_board_layout.dart';
import 'package:flutter/material.dart';

import '../widgets/list_board_layout.dart';

List<KanbanColumnEntity> initialKanbanData = [
  KanbanColumnEntity(
    title: 'To Do',
    status: 'todo',
    tasks: [
      TaskEntity(
        id: 'task-1',
        title: 'Urgent Tax Notice Response',
        company: 'Tech Innovations Pvt Ltd',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 46d 22h',
        loggedTime: '6h',
        assignees: 2,
        statusLabel: 'ToDo',
      ),
      TaskEntity(
        id: 'task-2',
        title: 'GSTR-3B Preparation',
        company: 'Green Energy Solutions',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 43d 22h',
        loggedTime: '2h',
        assignees: 2,
        statusLabel: 'ToDo',
      ),
    ],
    color: Colors.red.shade100,
  ),
  KanbanColumnEntity(
    title: 'In Progress',
    status: 'in_progress',
    tasks: [
      TaskEntity(
        id: 'task-3',
        title: 'ESI Return Filing',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 44d 22h',
        loggedTime: '3h',
        assignees: 1,
        statusLabel: 'Doing',
      ),
      TaskEntity(
        id: 'task-4',
        title: 'Audit Trail Documentation',
        company: 'Healthcare Associates',
        priority: 'Medium',
        priorityColor: Colors.amber.shade700,
        overdue: 'Overdue 42d 22h',
        loggedTime: '3h',
        assignees: 1,
        statusLabel: 'Doing',
      ),
    ],
    color: Colors.yellow.shade100,
  ),
  KanbanColumnEntity(
    title: 'Done',
    status: 'done',
    tasks: [
      TaskEntity(
        id: 'task-5',
        title: 'Client Onboarding - New Entity',
        company: 'Export Trading Co',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 34d 22h',
        loggedTime: '20h',
        assignees: 0,
        statusLabel: 'Done',
      ),
    ],
    color: Colors.green.shade100,
  ),
  KanbanColumnEntity(
    title: 'Review (TM)',
    status: 'review_tm',
    tasks: [
      TaskEntity(
        id: 'task-6',
        title: 'Payroll Reconciliation',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 39d 22h',
        loggedTime: '12h',
        assignees: 0,
        statusLabel: 'Review TM',
      ),
    ],
    color: Colors.blue.shade100,
  ),
  KanbanColumnEntity(
    title: 'Review (Ep)',
    status: 'review_ep',
    tasks: [
      TaskEntity(
        id: 'task-6',
        title: 'Payroll Reconciliation',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 39d 22h',
        loggedTime: '12h',
        assignees: 0,
        statusLabel: 'Review EP',
      ),
    ],
    color: Colors.blue.shade100,
  ),
  KanbanColumnEntity(
    title: 'Completed',
    status: 'completed',
    tasks: [
      TaskEntity(
        id: 'task-6',
        title: 'Payroll Reconciliation',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 39d 22h',
        loggedTime: '12h',
        assignees: 0,
        statusLabel: 'Completed',
      ),
    ],
    color: Colors.blue.shade100,
  ),
];

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TaskKanbanScreenState();
}

class _TaskKanbanScreenState extends State<TasksPage> {
  late List<KanbanColumnEntity> _kanbanData;

  int _selectedView = 1;

  static const double _buttonHeight = 48.0;
  static const double _borderRadius = 4.0;

  @override
  void initState() {
    super.initState();

    _kanbanData = List.from(initialKanbanData);
  }

  void _moveTask(TaskEntity task, String targetStatus) {
    setState(() {
      TaskEntity? taskToMove;
      int oldColIndex = -1;

      for (int i = 0; i < _kanbanData.length; i++) {
        final column = _kanbanData[i];
        final taskIndex = column.tasks.indexWhere((t) => t.id == task.id);

        if (taskIndex != -1) {
          taskToMove = column.tasks[taskIndex];
          oldColIndex = i;

          List<TaskEntity> newTasks = List.from(column.tasks);
          newTasks.removeAt(taskIndex);

          _kanbanData[i] = column.copyWith(tasks: newTasks);
          break;
        }
      }

      if (taskToMove != null) {
        final targetColIndex = _kanbanData.indexWhere(
          (col) => col.status == targetStatus,
        );

        if (targetColIndex != -1) {
          final newStatusLabel = _kanbanData[targetColIndex].title;

          final updatedTask = taskToMove.copyWith(statusLabel: newStatusLabel);

          List<TaskEntity> newTasks = List.from(
            _kanbanData[targetColIndex].tasks,
          );
          newTasks.add(updatedTask);

          _kanbanData[targetColIndex] = _kanbanData[targetColIndex].copyWith(
            tasks: newTasks,
          );
        } else {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),

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
                    fontFamily: 'Inter',
                    fontSize: context.scaleFont(24),
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage and track all your tasks efficiently.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: context.scaleFont(14),
                    color: Color(0xFF4A5565),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(
                //   height: 48,
                //   child: TextButton.icon(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.color_lens_outlined,
                //       size: 20,
                //       color: Color(0xFF4A5565),
                //     ),
                //     label: Text(
                //       'Color Guide',
                //       style: TextStyle(
                //         fontFamily: 'Inter',
                //         fontWeight: FontWeight.w500,
                //         fontSize: context.scaleFont(14),
                //         color: Color(0xFF0A0A0A),
                //       ),
                //     ),
                //     style: TextButton.styleFrom(
                //       padding: const EdgeInsets.symmetric(horizontal: 16),
                //     ),
                //   ),
                // ),

                // const SizedBox(width: 8),
                SizedBox(
                  height: 40,
                  child: ToggleButtons(
                    isSelected: [_selectedView == 0, _selectedView == 1],
                    onPressed: (int index) {
                      setState(() {
                        _selectedView = index;
                      });
                    },
                    renderBorder: true,
                    borderColor: AppColors.lightGreyBorder,
                    selectedBorderColor: AppColors.lightGreyBorder,
                    fillColor: AppColors.primaryDark,
                    color: Colors.transparent,
                    selectedColor: Colors.white,
                    borderRadius: BorderRadius.circular(9.0),
                    borderWidth: 1,
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth: 100,
                    ),
                    children: <Widget>[
                      // --- List Button ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.format_list_bulleted,
                              size: 16,
                              color: _selectedView == 0
                                  ? Colors.white
                                  : AppColors.darkGreyText,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'List',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: context.scaleFont(14),
                                fontWeight: FontWeight.w500,
                                color: _selectedView == 0
                                    ? Colors.white
                                    : AppColors.darkGreyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // --- List Button ends ---

                      // --- Kanban Button ---
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.dashboard_outlined,
                              size: 16,
                              color: _selectedView == 1
                                  ? Colors.white
                                  : AppColors.darkGreyText,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Kanban',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: context.scaleFont(14),
                                fontWeight: FontWeight.w500,
                                color: _selectedView == 1
                                    ? Colors.white
                                    : AppColors.darkGreyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // --- Kanban Button ends ---
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // .......................Export Section Starts.........................
                // SizedBox(
                //   height: 48,
                //   child: OutlinedButton.icon(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.file_download_outlined,
                //       size: 20,
                //       color: Color(0xFF4A5565),
                //     ),
                //     label: Text(
                //       'Export',
                //       style: TextStyle(
                //         fontFamily: 'Inter',
                //         fontSize: context.scaleFont(14),
                //         color: Color(0xFF4A5565),
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //     style: OutlinedButton.styleFrom(
                //       backgroundColor: Colors.white,
                //       side: const BorderSide(color: Color(0xFFE2E8F0)),
                //       padding: const EdgeInsets.symmetric(horizontal: 16),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(4),
                //       ),
                //       textStyle: TextStyle(fontSize: 14),
                //       elevation: 0,
                //     ),
                //   ),
                // ),
                // .......................Export Section Ends.........................

                // const SizedBox(width: 16),
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return const CreateNewTaskDialog();
                        },
                      );
                    },

                    icon: const Icon(Icons.add, size: 16),
                    label: Text(
                      'New Task',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: context.scaleFont(14),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryDark,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),

        _selectedView == 1
            ? KanbanBoardLayout(columns: _kanbanData, onTaskMove: _moveTask)
            : ListBoardLayout(),
      ],
    );
  }
}
