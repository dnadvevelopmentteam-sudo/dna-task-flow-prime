import 'package:flutter/material.dart';

class ClickableChip extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;
  final Widget? icon;
  final Color borderColor;
  final EdgeInsets padding;
  final double fontSize;

  const ClickableChip({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
    this.icon,
    this.borderColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        hoverColor: textColor.withOpacity(0.05),
        splashColor: textColor.withOpacity(0.1),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 4)],
              Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentTaskCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback? onCardTap;

  const RecentTaskCard({super.key, required this.data, this.onCardTap});

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return const Color(0xFFC70039);
      case 'Medium':
        return Colors.deepOrange.shade700;
      default:
        return Colors.blueGrey.shade600;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Doing':
        return Colors.blue.shade600;
      case 'ToDo':
        return Colors.grey.shade600;
      case 'Review TM':
        return Colors.deepOrange.shade600;
      case 'Done':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _getCardBackgroundColor(String priority) {
    switch (priority) {
      case 'High':
      case 'Medium':
        return const Color(0xFFFFECEC);
      default:
        return Colors.white;
    }
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${data['title']} Details'),
        content: const Text(
          'This is the task detail popup, triggered by clicking the card.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(data['priority'] as String);
    final statusColor = _getStatusColor(data['status'] as String);
    final cardBackgroundColor = _getCardBackgroundColor(
      data['priority'] as String,
    );

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: priorityColor.withOpacity(
            (data['priority'] == 'High' || data['priority'] == 'Medium')
                ? 0.4
                : 0.1,
          ),
        ),
      ),
      child: Material(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onCardTap ?? () => _showTaskDetails(context),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                            data['title'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data['client'] as String,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: priorityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        data['priority'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: priorityColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClickableChip(
                      text: 'Overdue ${data['overdue']}',
                      backgroundColor: priorityColor.withOpacity(0.1),
                      textColor: priorityColor,
                      borderColor: priorityColor.withOpacity(0.3),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Overdue details requested!'),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.warning_amber,
                        size: 14,
                        color: priorityColor,
                      ),
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.watch_later_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          data['hours'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.person_outline,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              data['assignee'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                        ),

                        ClickableChip(
                          text: data['status'] as String,
                          backgroundColor: statusColor.withOpacity(0.1),
                          textColor: statusColor,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Status change requested for ${data['status']}!',
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${data['comments']}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
