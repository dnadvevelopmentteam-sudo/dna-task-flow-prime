import 'package:dna_taskflow_prime/features/notices/presentation/pages/notices_page.dart';
import 'package:flutter/material.dart';

class DraftsTabContent extends StatelessWidget {
  const DraftsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.edit_note, size: 80, color: AppColorss.textLight),
          SizedBox(height: 16),
          Text(
            'You have no draft announcements.',
            style: TextStyle(color: AppColorss.textLight, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
