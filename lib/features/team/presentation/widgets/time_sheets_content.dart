import 'package:dna_taskflow_prime/features/team/data/models/time_sheet_models.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/load_more_button.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/time_entry_card.dart';
import 'package:flutter/material.dart';

class TimesheetsContent extends StatelessWidget {
  const TimesheetsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Recent Time Entries',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          ...timeEntries.map((entry) => TimeEntryCard(entry: entry)),

          const SizedBox(height: 30),

          Center(child: LoadMoreButton()),
        ],
      ),
    );
  }
}
