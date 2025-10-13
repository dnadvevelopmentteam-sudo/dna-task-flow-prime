import 'package:dna_taskflow_prime/features/team/data/models/approvals_models.dart';
import 'package:flutter/material.dart';

class BounceCard extends StatelessWidget {
  final BounceEntry entry;
  const BounceCard({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade100, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildInitialsCircle(entry.initials),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'First submitted ${entry.submissionDate}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              _BouncesTag(bounces: entry.bounces),
            ],
          ),

          // const Divider(height: 30, color: Color(0xFFEAEAEA)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Task:', entry.task, isBold: true),
              _buildDetailItem('Client:', entry.client, isBold: true),
              _buildDetailItem(
                'Last Bounce:',
                entry.lastBounceDate,
                isBold: true,
              ),
            ],
          ),
          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: Text(
              'Latest Issue: ${entry.latestIssue}',
              style: TextStyle(
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text(
            'Bounce History:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: entry.bounceHistory
                .map((history) => _buildHistoryTag(history))
                .toList(),
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              _ReviewEntryButton(onPressed: () {}),
              const SizedBox(width: 10),
              _ContactStaffButton(onPressed: () {}),
              const SizedBox(width: 10),
              _PatternAnalysisButton(onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInitialsCircle(String initials) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class ViewPatternAnalysisButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const ViewPatternAnalysisButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<ViewPatternAnalysisButton> createState() =>
      __ViewPatternAnalysisButtonState();
}

class __ViewPatternAnalysisButtonState
    extends State<ViewPatternAnalysisButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isHovered ? Colors.blue : Colors.black;
    Color bgColor = _isHovered ? Colors.blue.shade50 : Colors.transparent;
    Color borderColor = _isHovered ? Colors.blue : Colors.transparent;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton.icon(
        onPressed: widget.onPressed,
        icon: Icon(Icons.analytics_outlined, size: 18, color: color),
        label: Text(
          widget.text,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          side: BorderSide(color: borderColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }
}

class _ReviewEntryButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ReviewEntryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text(
        'Review Entry',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ContactStaffButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _ContactStaffButton({required this.onPressed});

  @override
  State<_ContactStaffButton> createState() => __ContactStaffButtonState();
}

class __ContactStaffButtonState extends State<_ContactStaffButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: _isHovered
              ? Colors.blue.shade50
              : Colors.transparent,
          side: BorderSide(
            color: _isHovered ? Colors.blue : Colors.grey.shade400,
            width: 1,
          ),
          foregroundColor: _isHovered ? Colors.blue.shade700 : Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'Contact Staff',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _PatternAnalysisButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _PatternAnalysisButton({required this.onPressed});

  @override
  State<_PatternAnalysisButton> createState() => __PatternAnalysisButtonState();
}

class __PatternAnalysisButtonState extends State<_PatternAnalysisButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          foregroundColor: _isHovered ? Colors.blue.shade700 : Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: const Text(
          'Pattern Analysis',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _BouncesTag extends StatefulWidget {
  final int bounces;
  const _BouncesTag({required this.bounces});

  @override
  State<_BouncesTag> createState() => __BouncesTagState();
}

class __BouncesTagState extends State<_BouncesTag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.red.shade700;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(_isHovered ? 0.8 : 1.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '${widget.bounces} Bounces',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
