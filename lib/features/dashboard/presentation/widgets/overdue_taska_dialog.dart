import 'package:flutter/material.dart';

// Placeholder for AppColors.primary
class AppColors {
  static const Color primary = Color(0xFF007bff);
}

class OverdueTasksDetailsContent extends StatelessWidget {
  final bool isMobile;
  const OverdueTasksDetailsContent({super.key, required this.isMobile});

  final List<Map<String, dynamic>> overdueTasks = const [
    {
      'title': 'Urgent Tax Notice Response',
      'company': 'Tech Innovations Pvt Ltd',
      'overdueDays': 2,
      'assignee': 'Priya Sharma',
      'dueDate': '8/16/2024',
      'reason': 'Awaiting client documentation',
      'impact': 'High - Penalty risk',
      'progress': 0.0,
      'tags': ['High', 'ToDo'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 781,
      height: 568,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color(0xFFFFFFFF),
      ),
      // color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          Flexible(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryCards(),
                    const SizedBox(height: 16),
                    _buildActionRequiredAlert(),
                    const SizedBox(height: 16),
                    _buildListHeader(),
                    const SizedBox(height: 16),
                    // Task List
                    ...overdueTasks.map((task) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _buildTaskListItem(
                          title: task['title'] as String,
                          company: task['company'] as String,
                          overdueDays: task['overdueDays'] as int,
                          assignee: task['assignee'] as String,
                          dueDate: task['dueDate'] as String,
                          reason: task['reason'] as String,
                          impact: task['impact'] as String,
                          progress: task['progress'] as double,
                          tags: task['tags'] as List<String>,
                        ),
                      );
                    }),
                    const SizedBox(height: 8),

                    _buildFooter(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
        right: 16.0,
        bottom: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFC10007)),
              const SizedBox(width: 8),
              Text(
                'Overdue Tasks Details',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  color: Color(0xFF0A0A0A),
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Color(0xFF333333),
              size: 15.99,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    final List<Map<String, dynamic>> summaryData = [
      {
        'title': 'Total Overdue',
        'value': 3,
        'color': Colors.red,
        'backgroundColor': Colors.red.shade50,
      },
      {
        'title': 'High Priority',
        'value': 2,
        'color': Colors.red,
        'backgroundColor': Colors.red.shade50,
      },
      {
        'title': 'Avg Days Late',
        'value': 2,
        'color': Colors.yellow.shade700,
        'backgroundColor': Colors.yellow.shade50,
      },
      {
        'title': 'Total Days Late',
        'value': 6,
        'color': Colors.green.shade700,
        'backgroundColor': Colors.green.shade50,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: summaryData.map((data) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: data == summaryData.last ? 0 : 10),
            child: _SummaryCard(
              title: data['title'] as String,
              value: data['value'] as int,
              valueColor: data['color'] as Color,
              backgroundColor: data['backgroundColor'] as Color,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionRequiredAlert() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6F6),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: Color(0xFFFED3D3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFC10007),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Immediate Action Required',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: Color(0xFFC10007),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have 2 high-priority overdue tasks that may impact client relationships and compliance. Please prioritize those tasks immediately.',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Color(0xFF4A5565),
                    fontWeight: FontWeight.w400,
                  ),
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
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF0A0A0A),
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.open_in_new,
            size: 13.99,
            color: Color(0xFF000000),
          ),
          label: const Text(
            'View All Tasks',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xFF000000),
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Color(0xFFFFFFFF),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            // padding: const EdgeInsets.symmetric(
            //   horizontal: 24.0,
            //   vertical: 16.0,
            // ),
            foregroundColor: const Color(0xFF000000),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskListItem({
    required String title,
    required String company,
    required int overdueDays,
    required String assignee,
    required String dueDate,
    required String reason,
    required String impact,
    required double progress,
    required List<String> tags,
  }) {
    final String progressHoursText = progress > 0
        ? 'Progress: ${(progress * 6).toStringAsFixed(1)}h / 6h'
        : 'Progress: 0h / 6h';

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey.shade200),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.05),
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF101828),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE2E2),
                        border: Border.all(
                          color: Color(0xFFFFA2A2),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Text(
                        '$overdueDays days overdue',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFC10007),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...tags.map((tag) {
                Color tagColor = tag == 'High'
                    ? Color(0xFFCA3500)
                    : Color(0xFF364153);
                return Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: _TaskTag(label: tag, color: tagColor),
                );
              }),
            ],
          ),
          const SizedBox(height: 4),

          // 2. Company Name
          Text(
            company,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Color(0xFF838383),
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 8),

          // 3. Assignee and Due Date
          Row(
            children: [
              const Icon(Icons.person, size: 13.99, color: Color(0xFF838383)),
              const SizedBox(width: 4),
              Text(
                assignee,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF838383),
                  fontSize: 10,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.calendar_today_outlined,
                size: 13.99,
                color: Color(0xFF838383),
              ),
              const SizedBox(width: 4),
              Text(
                'Due: $dueDate',
                style: TextStyle(
                  color: Color(0xFF838383),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 4. Reason and Impact
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              children: <TextSpan>[
                const TextSpan(
                  text: 'Reason: ',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A5565),
                  ),
                ),
                TextSpan(
                  text: '$reason\n',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A5565),
                  ),
                ),

                const TextSpan(
                  text: 'Impact: ',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A5565),
                  ),
                ),
                TextSpan(
                  text: impact,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFE7000B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 5. Progress Bar and Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    progressHoursText,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF6A7282),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF6A7282),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: progress,
                    backgroundColor: Color(0xFF030213).withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                ),
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
      // padding: const EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      // color: Colors.white,
      // border: Border(top: BorderSide(color: Colors.grey.shade200)),
      // ),
      child: SizedBox(
        width: 106,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0851B8),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Close',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFFFFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

// Summary Card Widget
class _SummaryCard extends StatelessWidget {
  final String title;
  final int value;
  final Color valueColor;
  final Color backgroundColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.valueColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 162.25,
      height: 90,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
          side: BorderSide(color: valueColor.withOpacity(0.5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Text(
                '$value',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Task Tag Widget
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
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: color.withOpacity(0.5), width: 1.0),
      ),

      child: Text(
        // label.toUpperCase(),
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
