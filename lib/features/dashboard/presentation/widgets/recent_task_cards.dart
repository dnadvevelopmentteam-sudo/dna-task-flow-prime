import 'package:flutter/material.dart';

class RecentTaskCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const RecentTaskCard({super.key, required this.data});

  // Returns the primary color (dark shade) for Priority and Overdue indicators
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red.shade700; // Stronger red for better contrast
      case 'Medium':
        return Colors.orange.shade700; // Stronger orange
      default:
        return Colors.grey.shade600;
    }
  }

  // Returns the primary color for the Status chip
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Doing':
        return Colors.blue.shade600;
      case 'ToDo':
        return Colors.grey.shade600;
      case 'Done':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  // Returns the background color for the entire card, applying the pink tint for urgent tasks
  Color _getCardBackgroundColor(String priority) {
    switch (priority) {
      case 'High':
      case 'Medium':
        // A very light pink/red color to match the screenshot's overall tint
        return const Color(0xFFFEF5F5);
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor(data['priority'] as String);
    final statusColor = _getStatusColor(data['status'] as String);
    final cardBackgroundColor = _getCardBackgroundColor(
      data['priority'] as String,
    );

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackgroundColor, // Light pink background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          // A subtle shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Title, Client, and Priority Chip (Top Row)
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
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              // Priority Chip (Top Right)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          // 2. Overdue Status Chip and Hours Logged (Middle Row)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Overdue Status Chip (Styled to match screenshot's prominent look)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: priorityColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber, size: 14, color: priorityColor),
                    const SizedBox(width: 4),
                    Text(
                      'Overdue ${data['overdue']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: priorityColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Hours Logged (Moved here to the right)
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
          // 3. Assignee, Status Chip, and Comments (Bottom Row)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Assignee and Status Chip Group
              Row(
                children: [
                  // Assignee
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

                  // Status Chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      data['status'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),

              // Comments (Aligned to the right)
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
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
