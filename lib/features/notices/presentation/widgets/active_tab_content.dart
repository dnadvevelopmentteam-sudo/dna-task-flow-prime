import 'package:dna_taskflow_prime/features/notices/data/models/notice_models.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/widgets/announcement_card_notices.dart';
import 'package:flutter/material.dart';

final List<Notice> mockNotices = [
  Notice(
    id: '1',
    title: 'New Employee Onboarding Resources',
    content:
        'We have updated our employee onboarding resources with new training materials and documentation. Check out the updated employee handbook and training videos on the portal. Welcome to all our new team members!',
    priority: Priority.normal,
    timeAgo: 'about 2 months ago',
    expiryDate: '15/09/2025',
    commentsCount: 0,
  ),
  Notice(
    id: '2',
    title: 'System Maintenance Scheduled',
    content:
        'Critical system maintenance will be performed this Saturday from 2:00 AM to 6:00 AM IST. All services will be temporarily unavailable. Please plan your work accordingly and save all progress before the maintenance window.',
    priority: Priority.critical,
    timeAgo: 'about 2 months ago',
    expiryDate: '23/08/2025',
    commentsCount: 0,
  ),
  Notice(
    id: '3',
    title: 'New GST Filing Deadline Updates',
    content:
        'Important updates regarding GST filing deadlines for Q4 2024. All team members handling GST compliance must review the updated guidelines in the knowledge base. Deadline extension requests must be submitted by end of this week.',
    priority: Priority.high,
    timeAgo: 'about 2 months ago',
    expiryDate: '30/08/2025',
    commentsCount: 1,
  ),
  Notice(
    id: '4',
    title: 'Team Meeting: Monthly Review',
    content:
        'Monthly team review meeting scheduled for next Friday at 3:00 PM. We will discuss project progress, upcoming deadlines, and address any concerns. Please prepare your status updates and bring any blockers to discuss.',
    priority: Priority.medium,
    timeAgo: 'about 2 months ago',
    expiryDate: '26/08/2025',
    commentsCount: 0,
  ),
];

class ActiveTabContent extends StatelessWidget {
  const ActiveTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockNotices.length,
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (context, index) {
        return AnnouncementCardNotices(notice: mockNotices[index]);
      },
    );
  }
}
