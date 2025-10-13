import 'package:dna_taskflow_prime/features/notices/data/models/notice_models.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/pages/notices_page.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/mark_as_read_button.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/priority_button.dart';
import 'package:flutter/material.dart';

class AnnouncementCardNotices extends StatelessWidget {
  final Notice notice;
  const AnnouncementCardNotices({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = notice.priority == Priority.critical
        ? AppColorss.critical
        : AppColorss.primary;
    final IconData statusIcon = notice.priority == Priority.critical
        ? Icons.info_outline
        : Icons.info_outline;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(statusIcon, size: 18, color: iconColor),
                    const SizedBox(width: 8),
                    Text(
                      notice.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColorss.textDark,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.visibility_outlined,
                      size: 16,
                      color: AppColorss.textLight,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${notice.commentsCount}',
                      style: const TextStyle(color: AppColorss.textLight),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  notice.timeAgo,
                  style: const TextStyle(
                    color: AppColorss.textLight,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 12),
                PriorityButton(priority: notice.priority),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              notice.content,
              style: const TextStyle(color: AppColorss.textDark, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expires: ${notice.expiryDate}',
                  style: const TextStyle(
                    color: AppColorss.textLight,
                    fontSize: 13,
                  ),
                ),
                MarkAsReadButton(
                  onPressed: () {
                    print('Marking notice ${notice.id} as read.');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
