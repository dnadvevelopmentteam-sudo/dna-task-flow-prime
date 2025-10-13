import 'package:dna_taskflow_prime/features/notices/presentation/pages/notices_page.dart';
import 'package:flutter/material.dart';

class ArchivedTabContent extends StatelessWidget {
  const ArchivedTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.archive_outlined, size: 80, color: AppColorss.textLight),
          SizedBox(height: 16),
          Text(
            'All announcements have been archived.',
            style: TextStyle(color: AppColorss.textLight, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
