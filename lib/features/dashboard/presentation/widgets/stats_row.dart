import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  void _showActiveTasksDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.95 : 860,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: ActiveTasksDialog(isMobile: isMobile),
          ),
        );
      },
    );
  }

  void _showHoursLoggedDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.95 : 860,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: HoursLoggedDialog(isMobile: isMobile),
          ),
        );
      },
    );
  }

  void _showOverdueTasks(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const OverdueTasksDialog();
      },
    );
  }

  void _showPointsBreakdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PointsBreakdownDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final cards = <Widget>[
      StatCard(
        title: 'Active Tasks',
        value: '24',
        subtitle: '3 due today',
        path: 'assets/icons/active.png',
        onTap: () {
          _showActiveTasksDialog(context);
        },
      ),
      StatCard(
        title: 'Hours Logged',
        value: '42.5',
        subtitle: 'This week',
        path: 'assets/icons/clock.png',
        onTap: () {
          _showHoursLoggedDialog(context);
        },
      ),
      StatCard(
        title: 'Overdue',
        value: '3',
        subtitle: 'Need attention',
        path: 'assets/icons/overdue.png',
        onTap: () {
          _showOverdueTasks(context);
        },
      ),
      StatCard(
        title: 'Points',
        value: '156',
        subtitle: 'Monthly rank #4',
        path: 'assets/icons/points.png',
        onTap: () {
          _showPointsBreakdown(context);
        },
      ),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cards
            .map(
              (card) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: card,
              ),
            )
            .toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards
            .map((card) => Expanded(child: card))
            .toList()
            .withSpacing(20),
      );
    }
  }
}

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
      {
        'value': '4',
        'label': 'Total Active',
        'color': const Color(0xFF1D4ED8),
      }, // Blue
      {
        'value': '1',
        'label': 'In Progress',
        'color': const Color(0xFFFBBF24),
      }, // Yellow
      {
        'value': '0',
        'label': 'Due Today',
        'color': const Color(0xFFEF4444),
      }, // Red
      {
        'value': '5.3h',
        'label': 'Hours Logged',
        'color': const Color(0xFF059669),
      }, // Green
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
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
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
        'progressValue': 0.63, // 63%
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
        'progressValue': 0.93, // 93%
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
      padding: const EdgeInsets.all(12),
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
              // Overdue indicator on the right (as per screenshot)
              if (overdue.isNotEmpty)
                const Text(
                  '▲ Overdue',
                  style: TextStyle(fontSize: 13, color: Color(0xFFDC2626)),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Row (Time Text vs. Percentage Text)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Progress Time Text (e.g., "2.5h / 4h")
              Text(
                progressTime,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500, // Matching screenshot style
                ),
              ),
              // Percentage Text (e.g., "63%") on the right
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500, // Matching screenshot style
                ),
              ),
            ],
          ),
          const SizedBox(height: 6), // Reduced space
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1D4ED8),
              ), // Blue progress
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
// ....................................Active Task Dialouge box ends. .............................

// --- Hours Logged  DIALOG WIDGET --- Starts

class OverviewData {
  final String value;
  final String label;
  final Color color;

  OverviewData({required this.value, required this.label, required this.color});
}

class DailyBreakdownEntry {
  final String day;
  final int taskCount;
  final double hours;

  DailyBreakdownEntry({
    required this.day,
    required this.taskCount,
    required this.hours,
  });
}

class TimeEntry {
  final String taskTitle;
  final String company;
  final String date;
  final double hours;
  final String status;

  TimeEntry({
    required this.taskTitle,
    required this.company,
    required this.date,
    required this.hours,
    required this.status,
  });
}

// --- HOURS LOGGED DIALOG WIDGET ---

class HoursLoggedDialog extends StatelessWidget {
  final bool isMobile;
  HoursLoggedDialog({super.key, required this.isMobile});
  // HoursLoggedDialog({super.key});

  final List<OverviewData> overviewData = [
    OverviewData(
      value: '42.2',
      label: 'Total Active',
      color: Color(0xFF1D4ED8),
    ),
    OverviewData(value: '40h', label: 'In Progress', color: Color(0xFFFBBF24)),
    OverviewData(value: '0', label: 'Due Today', color: Color(0xFFEF4444)),
    OverviewData(
      value: '5.3h',
      label: 'Hours Logged',
      color: Color(0xFF059669),
    ),
  ];

  final List<DailyBreakdownEntry> dailyBreakdown = [
    DailyBreakdownEntry(day: 'Tuesday', taskCount: 3, hours: 8.3),
    DailyBreakdownEntry(day: 'Tuesday', taskCount: 3, hours: 8.3),
    // Add more entries if needed for scroll demonstration
    DailyBreakdownEntry(day: 'Wednesday', taskCount: 2, hours: 4.5),
  ];

  final List<TimeEntry> recentEntries = [
    TimeEntry(
      taskTitle: 'GSTR-1 Filing for Acme Corp',
      company: 'Acme Corporation',
      date: '8/16/2024',
      hours: 8.3,
      status: 'Approved',
    ),
    TimeEntry(
      taskTitle: 'GSTR-1 Filing for Acme Corp',
      company: 'Acme Corporation',
      date: '8/16/2024',
      hours: 8.3,
      status: 'Approved',
    ),
    TimeEntry(
      taskTitle: 'Quarterly Audit Report',
      company: 'Global Dynamics Inc',
      date: '8/15/2024',
      hours: 4.0,
      status: 'Approved',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        color: Color(0xFFFFFFFF),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverviewSection(context),
                    SizedBox(height: 20),
                    _buildDailyBreakdownSection(),

                    // Recent Time Entries Section
                    _buildRecentTimeEntriesSection(),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            // Footer with Close Button
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Hours Logged Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: overviewData
            .map((data) => Expanded(child: _OverviewCard(data: data)))
            .toList(),
      ),
    );
  }

  Widget _buildDailyBreakdownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Breakdown - This Week',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dailyBreakdown.length,
          itemBuilder: (context, index) {
            return _DailyBreakdownItem(entry: dailyBreakdown[index]);
          },
        ),
      ],
    );
  }

  Widget _buildRecentTimeEntriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Time Entries',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentEntries.length,
          itemBuilder: (context, index) {
            return _TimeEntryItem(entry: recentEntries[index]);
          },
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.centerRight,

      child: SizedBox(
        width: 120,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 2,
          ),
          child: Text(
            'Close',
            style: TextStyle(
              fontFamily: 'Inter',
              // fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// --- WIDGET COMPONENTS ---

class _OverviewCard extends StatelessWidget {
  final OverviewData data;
  const _OverviewCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: data.color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyBreakdownItem extends StatelessWidget {
  final DailyBreakdownEntry entry;
  const _DailyBreakdownItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    final double progressValue = entry.hours / 8.0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.blueGrey,
                ),
                const SizedBox(width: 8),
                Text(
                  entry.day,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  '${entry.taskCount} Tasks',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(width: 10),
                Text(
                  '${entry.hours}h',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Progress Bar
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF059669),
              ), // Green color for logged hours
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeEntryItem extends StatelessWidget {
  final TimeEntry entry;
  const _TimeEntryItem({required this.entry});

  @override
  Widget build(BuildContext context) {
    final statusColor = entry.status == 'Approved'
        ? const Color(0xFF059669)
        : Colors.amber;

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.taskTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${entry.company} • ${entry.date}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Hours Logged
          Text(
            '${entry.hours}h',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 15),
          // Status Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              entry.status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ....................................Hours Logged  Dialouge box ends. .............................

// --- OVERDUE TASK DIALOG WIDGET STARTS ---
class OverdueTasksDialog extends StatelessWidget {
  const OverdueTasksDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Using AlertDialog for a modal-like popup,
    // setting contentPadding to zero to control the layout fully.
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

      // Use a custom widget for the content so we can have
      // the title, content, and close button all together.
      content: const OverdueTasksDetailsContent(),
    );
  }
}

// --- Content Widget to build the complex UI structure ---
class OverdueTasksDetailsContent extends StatelessWidget {
  const OverdueTasksDetailsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, // Approximate width for desktop-like dialog
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header with Title and Close Button
          _buildHeader(context),
          const Divider(height: 1),

          // 2. Summary Cards Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(),
                const SizedBox(height: 16),

                // 3. Immediate Action Required Alert
                _buildActionRequiredAlert(),
                const SizedBox(height: 16),

                // 4. Overdue Tasks Details Header
                _buildListHeader(),
                const SizedBox(height: 8),

                // 5. Task List Item (Example)
                _buildTaskListItem(
                  title: 'Urgent Tax Notice Response',
                  overdueDays: 2,
                  assignee: 'Priya Sharma',
                  dueDate: '08/30/2024',
                  reason:
                      'Amazing client documentation. Impact: High - Penalty risk',
                  progress: 0.0, // 0%
                ),
                // (In a real app, you would use a ListView.builder here)
              ],
            ),
          ),

          // 6. Footer/Action Button
          _buildFooter(context),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.red),
              const SizedBox(width: 8),
              Text(
                'Overdue Tasks Details',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SummaryCard(title: 'Total Overdue', value: 3),
        SizedBox(width: 10),
        _SummaryCard(title: 'High Priority', value: 2),
        SizedBox(width: 10),
        _SummaryCard(title: 'Avg Days Late', value: 2),
        SizedBox(width: 10),
        _SummaryCard(title: 'Total Days Late', value: 6),
      ],
    );
  }

  Widget _buildActionRequiredAlert() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05), // Light red background
        borderRadius: BorderRadius.circular(4.0),
        border: const Border(left: BorderSide(color: Colors.red, width: 4)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning, color: Colors.red, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Immediate Action Required',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'You have 2 high-priority overdue tasks that may impact client relationships and compliance. Please prioritize those tasks immediately.',
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Overdue Tasks Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextButton(onPressed: () {}, child: const Text('View All Tasks')),
      ],
    );
  }

  Widget _buildTaskListItem({
    required String title,
    required int overdueDays,
    required String assignee,
    required String dueDate,
    required String reason,
    required double progress,
  }) {
    // The grey box around the item is typically achieved with a Card or Container
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Overdue Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$overdueDays days overdue',
                  style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Assignee, Due Date, and Priority Tags
          Row(
            children: [
              Text(
                assignee,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.circle, size: 4, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                'Due: $dueDate',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const Spacer(),
              _TaskTag(label: 'High', color: Colors.red),
              const SizedBox(width: 4),
              _TaskTag(label: 'ToDo', color: Colors.blue), // Example tag
            ],
          ),
          const SizedBox(height: 8),

          // Reason/Impact
          Text('Reason: $reason', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 8),

          // Progress Bar
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: progress, // 0.0 for 0%
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.green,
                  ), // Assuming progress is green
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),

      child: SizedBox(
        width: 120,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ), // Rounded corners for button
            ),
            elevation: 2,
          ),
          child: Text(
            'Close',
            style: TextStyle(
              fontFamily: 'Inter',
              // fontSize: context.scaleFont(14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

// Card for the summary statistics (e.g., Total Overdue)
class _SummaryCard extends StatelessWidget {
  final String title;
  final int value;

  const _SummaryCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700, // Color of the numbers
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tag for task priority/status (e.g., High, ToDo)
class _TaskTag extends StatelessWidget {
  final String label;
  final Color color;

  const _TaskTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          // color: color.shade700,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// --- OVERDUE TASK DIALOG WIDGET ENDS ---

// --- POINTS BREAKDOWN DIALOG WIDGET STARTS ---

class PointsBreakdownDialog extends StatelessWidget {
  const PointsBreakdownDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // Using AlertDialog for a modal-like popup.
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),

      // Use a custom widget for the content to control the layout fully.
      content: const PointsBreakdownContent(),
    );
  }
}

// --- Content Widget to build the complex UI structure ---
class PointsBreakdownContent extends StatelessWidget {
  const PointsBreakdownContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, // Approximate width for desktop-like dialog
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header with Title and Close Button
          _buildHeader(context),
          const Divider(height: 1),

          // 2. Main Content Area with Padding
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3. Summary Cards Section
                _buildSummaryCards(),
                const SizedBox(height: 16),

                // 4. Point Allocation Rules Card
                _buildAllocationRulesCard(context),
                const SizedBox(height: 16),

                // 5. Recent Activity Card
                _buildRecentActivityCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Points Breakdown',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SummaryCards(
          title: 'Total Points',
          value: 0,
          icon: Icons.star_border,
          valueColor: Colors.blue,
        ),
        SizedBox(width: 10),
        _SummaryCards(
          title: 'Total Points',
          value: 0,
          icon: Icons.star_border,
          valueColor: Colors.blue,
        ),
        SizedBox(width: 10),
        _SummaryCards(
          title: 'Awards',
          value: 0,
          prefix: '+',
          icon: Icons.emoji_events_outlined,
          valueColor: Colors.green,
        ),
        SizedBox(width: 10),
        _SummaryCards(
          title: 'Penalties',
          value: 0,
          prefix: '+',
          icon: Icons.gpp_bad_outlined,
          valueColor: Colors.red,
        ),
      ],
    );
  }

  Widget _buildAllocationRulesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Point Allocation Rules',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Divider(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Earning Points Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earning Points:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRuleItem(
                      icon: Icons.task_alt,
                      text: 'Task completed before due date: +10 points',
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              const VerticalDivider(width: 32),

              // Earning Points (Deductions) Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earning Points:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRuleItem(
                      icon: Icons.error_outline,
                      text: 'Task not completed by due date: -10 points',
                      color: Colors.red,
                    ),
                    _buildRuleItem(
                      icon: Icons.warning_amber,
                      text: 'Quality not satisfactory: -5 points',
                      color: Colors.red,
                    ),
                    _buildRuleItem(
                      icon: Icons.cancel_outlined,
                      text: 'Award reversed due to review bounce: -10 points',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRuleItem({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long, color: Colors.black54),
              const SizedBox(width: 8),
              Text(
                'Recent Activity',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Divider(height: 20),

          // Placeholder for "No points activity yet"
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No points activity yet',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Helper Widget for the Summary Cards ---
class _SummaryCards extends StatelessWidget {
  final String title;
  final int value;
  final String? prefix;
  final IconData icon;
  final Color valueColor;

  const _SummaryCards({
    required this.title,
    required this.value,
    this.prefix,
    required this.icon,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(icon, size: 24, color: valueColor),
                  const SizedBox(width: 8),
                  Text(
                    '${prefix ?? ''}$value',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- POINTS BREAKDOWN DIALOG WIDGET ENDS ---
