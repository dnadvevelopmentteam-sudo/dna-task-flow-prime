// import 'package:dna_taskflow_prime/features/team/data/models/approvals_models.dart';
// import 'package:flutter/material.dart';

// class StatCard extends StatelessWidget {
//   final MetricStat stat;
//   const StatCard({required this.stat, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(right: 20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: stat.baseColor,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(stat.icon, color: stat.iconColor, size: 24),
//           ),
//           const SizedBox(width: 15),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 stat.value,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 stat.title,
//                 style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:dna_taskflow_prime/features/team/data/models/approvals_models.dart';
import 'package:flutter/material.dart';

class ApprovalCard extends StatelessWidget {
  final ApprovalRequest request;
  const ApprovalCard({required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    final daysPending = int.tryParse(request.daysPending.split(' ')[0]) ?? 0;
    final progress = (daysPending / request.targetDays).clamp(0.0, 1.0);
    final isOverdue = progress > 1.0;

    Color progressColor = isOverdue
        ? Colors.red.shade600
        : Colors.blue.shade700;
    if (!isOverdue && progress >= 0.6) progressColor = AppColors.primaryDark;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildInitialsCircle(request.initials),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Submitted ${request.submissionDate}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  _PendingTag(text: 'Pending: ${request.pendingAt}'),
                  if (request.canEscalate) const SizedBox(width: 8),
                  if (request.canEscalate) _EscalateTag(),
                ],
              ),
            ],
          ),

          // const Divider(height: 30, color: Color(0xFFEAEAEA)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Task:', request.task, isBold: true),
              _buildDetailItem('Client:', request.client, isBold: true),
              _buildDetailItem('Duration:', request.duration, isBold: true),
              _buildDetailItem(
                'Days Pending:',
                request.daysPending,
                isRed: isOverdue,
              ),
            ],
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SLA Progress (Target: ${request.targetDays} day${request.targetDays > 1 ? 's' : ''})',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(progress > 1 ? 0 : 0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isOverdue ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              _ApproveNowButton(onPressed: () {}),
              const SizedBox(width: 10),
              _RequestChangesButton(onPressed: () {}),
              const SizedBox(width: 10),
              _AddNoteButton(onPressed: () {}),
              const SizedBox(width: 10),
              if (request.canEscalate) _EscalateButton(onPressed: () {}),
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

  Widget _buildDetailItem(
    String title,
    String value, {
    bool isBold = false,
    bool isRed = false,
  }) {
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
            color: isRed ? Colors.red.shade700 : Colors.black,
          ),
        ),
      ],
    );
  }
}

class _ApproveNowButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ApproveNowButton({required this.onPressed});

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
        'Approve Now',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _RequestChangesButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _RequestChangesButton({required this.onPressed});

  @override
  State<_RequestChangesButton> createState() => __RequestChangesButtonState();
}

class __RequestChangesButtonState extends State<_RequestChangesButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: _isHovered ? Colors.red.shade50 : Colors.transparent,
          side: BorderSide(
            color: _isHovered ? Colors.red : Colors.grey.shade400,
            width: 1,
          ),
          foregroundColor: _isHovered ? Colors.red.shade700 : Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'Request Changes',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _AddNoteButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _AddNoteButton({required this.onPressed});

  @override
  State<_AddNoteButton> createState() => __AddNoteButtonState();
}

class __AddNoteButtonState extends State<_AddNoteButton> {
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
          'Add Note',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _EscalateButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _EscalateButton({required this.onPressed});

  @override
  State<_EscalateButton> createState() => __EscalateButtonState();
}

class __EscalateButtonState extends State<_EscalateButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered
              ? Colors.red.shade700.withOpacity(0.8)
              : Colors.red.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: const Text(
          'Escalate',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _PendingTag extends StatefulWidget {
  final String text;
  const _PendingTag({required this.text});

  @override
  State<_PendingTag> createState() => __PendingTagState();
}

class __PendingTagState extends State<_PendingTag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.grey.shade700;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(_isHovered ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _EscalateTag extends StatefulWidget {
  const _EscalateTag();

  @override
  State<_EscalateTag> createState() => __EscalateTagState();
}

class __EscalateTagState extends State<_EscalateTag> {
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
        child: const Text(
          'Escalate',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
