import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ActiveTasksDialog extends StatelessWidget {
  final bool isMobile;
  const ActiveTasksDialog({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      elevation: 24,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0, vertical: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(context),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverviewSection(context),
                    const SizedBox(height: 20),
                    _buildTasksListSection(),
                    SizedBox(height: 20),

                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Active Tasks Overview',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: context.scaleFont(16),
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0A0A0A),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    final stats = [
      {'value': '4', 'label': 'Total Active', 'color': const Color(0xFF1D4ED8)},
      {'value': '1', 'label': 'In Progress', 'color': const Color(0xFFFBBF24)},
      {'value': '0', 'label': 'Due Today', 'color': const Color(0xFFEF4444)},
      {
        'value': '5.3h',
        'label': 'Hours Logged',
        'color': const Color(0xFF059669),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 500 ? 4 : 2;
        final childAspectRatio = constraints.maxWidth > 500 ? 1.9 : 2.2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            return _TaskOverviewCard(
              value: stats[index]['value']! as String,
              label: stats[index]['label']! as String,
              color: stats[index]['color'] as Color,
            );
          },
        );
      },
    );
  }

  Widget _buildTasksListSection() {
    final tasks = [
      {
        'title': 'GSTR-1 Filing for Acme Corp',
        'client': 'Acme Corporation',
        'assignee': 'Priya Sharma',
        'tag': 'High',
        'status': 'Doing',
        'overdue': 'Overdue 421d 11h',
        'progressText': 'Progress: 2.5h / 4h',
        'progressValue': 0.63,
      },
      {
        'title': 'Income Tax Return - Q2 Review',
        'client': 'Tech Solutions Ltd',
        'assignee': 'Priya Sharma',
        'tag': 'Medium',
        'status': 'ToDo',
        'overdue': 'Overdue 419d 11h',
        'progressText': 'Progress: 0h / 6h',
        'progressValue': 0.0,
      },
      {
        'title': 'Unlabeled Task',
        'client': 'Tech Solutions Ltd',
        'assignee': 'Priya Sharma',
        'tag': 'High',
        'status': 'Overdue',
        'overdue': 'Overdue 419d 11h',
        'progressText': 'Progress: 0h / 6h',
        'progressValue': 0.0,
      },
      {
        'title': 'TDS Compliance Check',
        'client': 'Manufacturing Co',
        'assignee': 'Priya Sharma',
        'tag': 'High',
        'status': 'Review TM',
        'overdue': 'Overdue 423d 11h',
        'progressText': 'Progress: 2.8h / 3h',
        'progressValue': 0.93,
      },
      {
        'title': 'Monthly MIS Report',
        'client': 'Retail Stores Pvt',
        'assignee': 'Priya Sharma',
        'tag': 'Low',
        'status': 'ToDo',
        'overdue': 'Overdue 416d 11h',
        'progressText': 'Progress: 0h / 2h',
        'progressValue': 0.0,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Active Tasks',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            color: Color(0xFF101828),
          ),
        ),
        const SizedBox(height: 12),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == tasks.length - 1 ? 0 : 12.0,
              ),
              child: _TaskListItem(
                title: task['title'] as String,
                client: task['client'] as String,
                assignee: task['assignee'] as String,
                tag: task['tag'] as String,
                status: task['status'] as String,
                overdue: task['overdue'] as String,
                progressText: task['progressText'] as String,
                progressValue: task['progressValue'] as double,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      alignment: Alignment.centerRight,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).cardColor,
      //   border: Border(top: BorderSide(color: Colors.grey.shade100, width: 1)),
      // ),
      child: SizedBox(
        width: 120,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 2,
          ),
          child: Text(
            'Close',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskOverviewCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _TaskOverviewCard({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(
        //   color: Colors.grey.shade300, width: 1),
      ),
      padding: const EdgeInsets.all(2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: context.scaleFont(20),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: context.scaleFont(12),
              color: const Color(0xFF4A5565),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskListItem extends StatelessWidget {
  final String title;
  final String client;
  final String assignee;
  final String tag;
  final String status;
  final String overdue;
  final String progressText;
  final double progressValue;

  const _TaskListItem({
    required this.title,
    required this.client,
    required this.assignee,
    required this.tag,
    required this.status,
    required this.overdue,
    required this.progressText,
    required this.progressValue,
  });

  Color _getTagColor() {
    switch (tag.toLowerCase()) {
      case 'high':
        return const Color(0xFFEF4444);
      case 'medium':
        return const Color(0xFFFBBF24);
      case 'low':
        return const Color(0xFF10B981);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'doing':
        return const Color(0xFF1D4ED8);
      case 'review tm':
        return const Color(0xFFFBBF24);
      case 'todo':
        return Colors.grey.shade600;
      case 'overdue':
        return const Color(0xFFDC2626);
      default:
        return Colors.grey;
    }
  }

  Widget _buildChip({
    required String text,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: textColor.withOpacity(0.2), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildOverdueChip() {
    if (overdue.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            size: 14,
            color: Color(0xFFDC2626),
          ),
          const SizedBox(width: 4),
          Text(
            'Overdue $overdue',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFDC2626),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tagColor = _getTagColor();
    final statusColor = _getStatusColor();
    final percentage = (progressValue * 100).toInt();
    final progressTime = progressText.replaceAll('Progress: ', '');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      client,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildChip(
                    text: tag,
                    backgroundColor: tagColor.withOpacity(0.05),
                    textColor: tagColor,
                  ),
                  const SizedBox(width: 8),
                  _buildChip(
                    text: status,
                    backgroundColor: statusColor.withOpacity(0.05),
                    textColor: statusColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 14,
                    color: Color(0xFF4A5565),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    assignee,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                  if (overdue.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    _buildOverdueChip(),
                  ],
                ],
              ),
              if (overdue.isNotEmpty)
                const Text(
                  'Overdue',
                  style: TextStyle(fontSize: 13, color: Color(0xFFDC2626)),
                ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                progressTime,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1D4ED8),
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
