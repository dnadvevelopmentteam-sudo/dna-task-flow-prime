import 'package:dna_taskflow_prime/features/team/data/models/approvals_models.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/approval_card.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/bounce_card.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class ApprovalsContent extends StatelessWidget {
  const ApprovalsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: metrics
                .map((stat) => Expanded(child: StatCard(stat: stat)))
                .toList(),
          ),
          const SizedBox(height: 40),

          _buildHeader(
            'Longest Pending Approvals',
            Icons.access_time_outlined,
            'View All',
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          ...pendingApprovals.map((req) => ApprovalCard(request: req)),
          const SizedBox(height: 40),

          _buildHeader(
            'Tasks with Repeated Review Bounces',
            Icons.repeat_rounded,
            'View Pattern Analysis',
            isBounceSection: true,
            onPressed: () {},
          ),
          const SizedBox(height: 20),
          ...bouncedEntries.map((bounce) => BounceCard(entry: bounce)),
        ],
      ),
    );
  }

  Widget _buildHeader(
    String title,
    IconData icon,
    String actionText, {
    required VoidCallback onPressed,
    bool isBounceSection = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black, size: 24),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          isBounceSection
              ? ViewPatternAnalysisButton(
                  text: actionText,
                  onPressed: onPressed,
                )
              : _ViewAllButton(text: actionText, onPressed: onPressed),
        ],
      ),
    );
  }
}

class _ViewAllButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  const _ViewAllButton({required this.text, required this.onPressed});

  @override
  State<_ViewAllButton> createState() => __ViewAllButtonState();
}

class __ViewAllButtonState extends State<_ViewAllButton> {
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
        icon: Icon(Icons.remove_red_eye_outlined, size: 18, color: color),
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
