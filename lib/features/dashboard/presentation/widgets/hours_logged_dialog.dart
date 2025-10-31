import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class OverviewData {
  final String value;
  final String label;
  final Color color;
  final IconData? icon;

  OverviewData({
    required this.value,
    required this.label,
    required this.color,
    this.icon,
  });
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
  final String tag;
  final String company;
  final String date;
  final double hours;
  final String status;

  TimeEntry({
    required this.taskTitle,
    required this.tag,
    required this.company,
    required this.date,
    required this.hours,
    required this.status,
  });
}

class HoursLoggedDialog extends StatelessWidget {
  final bool isMobile;
  HoursLoggedDialog({super.key, required this.isMobile});

  final List<OverviewData> overviewData = [
    OverviewData(
      value: '42.5h',
      label: 'This Week',
      color: const Color(0xFF1D4ED8),
      icon: Icons.access_time,
    ),
    OverviewData(
      value: '40h',
      label: 'Target',
      color: const Color(0xFFFBBF24),
      icon: Icons.flag,
    ),
    OverviewData(
      value: '2.5h',
      label: 'Over Target',
      color: const Color(0xFF059669),
      icon: Icons.trending_up,
    ),
    OverviewData(
      value: '12.8h',
      label: 'Approved',
      color: const Color(0xFF059669),
      icon: Icons.check_circle_outline,
    ),
  ];

  final List<DailyBreakdownEntry> dailyBreakdown = [
    DailyBreakdownEntry(day: 'Monday', taskCount: 3, hours: 8.5),
    DailyBreakdownEntry(day: 'Tuesday', taskCount: 4, hours: 7.8),
    DailyBreakdownEntry(day: 'Wednesday', taskCount: 2, hours: 8.2),
    DailyBreakdownEntry(day: 'Thursday', taskCount: 5, hours: 9.1),
    DailyBreakdownEntry(day: 'Friday', taskCount: 3, hours: 8.9),
  ];

  final List<TimeEntry> recentEntries = [
    TimeEntry(
      taskTitle: 'GSTR-1 Filing for Acme Corp',
      tag: 'Compliance',
      company: 'Acme Corporation',
      date: '16/08/2024',
      hours: 3.5,
      status: 'Approved',
    ),
    TimeEntry(
      taskTitle: 'TDS Compliance Check',
      tag: 'Review',
      company: 'Manufacturing Co',
      date: '16/08/2024',
      hours: 2.8,
      status: 'Pending',
    ),
    TimeEntry(
      taskTitle: 'Monthly MIS Report',
      tag: 'Reporting',
      company: 'Retail Stores Pvt',
      date: '15/08/2024',
      hours: 4.2,
      status: 'Approved',
    ),
    TimeEntry(
      taskTitle: 'Income Tax Return Review',
      tag: 'Tax',
      company: 'Tech Solutions Ltd',
      date: '15/08/2024',
      hours: 5.1,
      status: 'Approved',
    ),
    TimeEntry(
      taskTitle: 'Audit Documentation',
      tag: 'Audit',
      company: 'Healthcare Associates',
      date: '14/08/2024',
      hours: 6.3,
      status: 'Rejected',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    _buildOverviewSection(context),
                    const SizedBox(height: 20),
                    _buildDailyBreakdownSection(),
                    const SizedBox(height: 20),
                    _buildRecentTimeEntriesSection(),
                    const SizedBox(height: 20),
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
      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Hours Logged Details',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A0A0A),
            ),
          ),
          IconButton(
            iconSize: 16,
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
            .map(
              (data) => Expanded(
                child: _OverviewCard(data: data, color: data.color),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDailyBreakdownSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Breakdown - This Week',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101828),
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
      ),
    );
  }

  Widget _buildRecentTimeEntriesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Time Entries',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF101828),
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
      ),
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
          child: const Text(
            'Close',
            style: TextStyle(
              fontFamily: 'Inter',
              // fontSize: context.scaleFont(14),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final OverviewData data;
  final Color color;
  const _OverviewCard({required this.data, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.value,
            // textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: context.scaleFont(24),
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              color: Color(0xFF4A5565),
              fontWeight: FontWeight.w400,
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
    final double clampedProgressValue = progressValue.clamp(0.0, 1.0);

    const Color trackColor = Color(0xFFE5E7EB);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              size: 16,
              color: Color(0xFF0A0A0A),
            ),
            const SizedBox(width: 8),
            Text(
              entry.day,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF000000),
              ),
            ),

            const Spacer(),
            Text(
              '${entry.taskCount} tasks',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF737373),
              ),
            ),
            const SizedBox(width: 10),

            Text(
              '${entry.hours}h',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF737373),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 0,
              child: SizedBox(
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: clampedProgressValue,
                    backgroundColor: trackColor,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primaryDark,
                    ),
                    minHeight: 9,
                  ),
                ),
              ),
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
    Color statusColor;
    switch (entry.status) {
      case 'Approved':
        statusColor = const Color(0xFF059669);
        break;
      case 'Pending':
        statusColor = const Color(0xFFFBBF24);
        break;
      case 'Rejected':
        statusColor = const Color(0xFFEF4444);
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.taskTitle,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          // color: Color(0xFFFFFFFF),
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text(
                          entry.tag,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0A0A0A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: Color(0xFF969696),
                      ),
                      children: <InlineSpan>[
                        TextSpan(text: '${entry.company} '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9.0,
                            ),
                            child: Icon(
                              Icons.calendar_today,
                              size: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        TextSpan(text: ' ${entry.date}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.watch_later_outlined,
              size: 20,
              color: Colors.grey,
            ),
            SizedBox(width: 10),
            Text(
              '${entry.hours}h',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: statusColor.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                entry.status,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
