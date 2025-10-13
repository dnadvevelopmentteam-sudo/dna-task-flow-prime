import 'package:dna_taskflow_prime/features/team/data/models/time_sheet_models.dart';
import 'package:flutter/material.dart';

class TimeEntryCard extends StatefulWidget {
  final TimeEntry entry;
  const TimeEntryCard({required this.entry, super.key});

  @override
  State<TimeEntryCard> createState() => _TimeEntryCardState();
}

class _TimeEntryCardState extends State<TimeEntryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;

    Color statusColor;
    String statusText;
    switch (entry.status) {
      case TimesheetStatus.approved:
        statusColor = Colors.blue.shade700;
        statusText = 'Approved';
        break;
      case TimesheetStatus.pending:
        statusColor = Colors.grey.shade700;
        statusText = 'Pending Review';
        break;
      case TimesheetStatus.changesRequested:
        statusColor = Colors.red.shade600;
        statusText = 'Changes Requested';
        break;
    }

    Color initialsBg = Colors.grey.shade200;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: initialsBg,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    entry.initials,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${entry.team} • ${entry.date}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                _buildTag(statusText, statusColor),
                const SizedBox(width: 8),
                _buildTag(
                  entry.type == EntryType.timer ? 'timer' : 'manual',
                  Colors.grey.shade400,
                  textColor: Colors.black,
                  isOutline: true,
                ),
              ],
            ),
            const Divider(height: 30, color: Color(0xFFEAEAEA)),

            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(Icons.apartment_outlined, entry.client),
                ),
                Expanded(
                  child: _buildInfoItem(Icons.schedule, entry.timeRange),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.access_time,
                    'Duration: ${entry.duration}',
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    Icons.assessment_outlined,
                    'Coverage: ${entry.coverage.toStringAsFixed(0)}%',
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            Text(
              entry.project,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              entry.service,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Remark: ${entry.remark}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            const SizedBox(height: 15),

            Text(
              'Screenshot Coverage',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: entry.coverage / 100,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.blue,
                      ),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${entry.coverage.toStringAsFixed(0)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(
    String text,
    Color color, {
    Color? textColor,
    bool isOutline = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: isOutline ? Border.all(color: color, width: 1) : null,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text, [Color? color]) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color ?? Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: color ?? Colors.grey.shade700,
            fontSize: 14,
            fontWeight: color != null ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
