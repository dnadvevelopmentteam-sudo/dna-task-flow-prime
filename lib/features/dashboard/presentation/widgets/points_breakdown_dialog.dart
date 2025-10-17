import 'package:flutter/material.dart';

class PointsBreakdownContent extends StatelessWidget {
  final bool isMobile;
  const PointsBreakdownContent({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
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

                _buildAllocationRulesCard(context),
                const SizedBox(height: 16),

                _buildRecentActivityCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

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
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.grey.shade600,
                    ),
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
        color: Color(0xFFFFFFFF),
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.0),
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
