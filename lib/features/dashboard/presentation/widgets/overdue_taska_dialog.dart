import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class OverdueTasksDetailsContent extends StatelessWidget {
  final bool isMobile;
  const OverdueTasksDetailsContent({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCards(),
                const SizedBox(height: 16),

                _buildActionRequiredAlert(),
                const SizedBox(height: 16),

                _buildListHeader(),
                const SizedBox(height: 8),

                _buildTaskListItem(
                  title: 'Urgent Tax Notice Response',
                  overdueDays: 2,
                  assignee: 'Priya Sharma',
                  dueDate: '08/30/2024',
                  reason:
                      'Amazing client documentation. Impact: High - Penalty risk',
                  progress: 0.0,
                ),
                SizedBox(height: 16),
                _buildFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
        color: Colors.red.withOpacity(0.05),
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
              _TaskTag(label: 'ToDo', color: Colors.blue),
            ],
          ),
          const SizedBox(height: 8),

          Text('Reason: $reason', style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
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
                  color: Colors.red.shade700,
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
