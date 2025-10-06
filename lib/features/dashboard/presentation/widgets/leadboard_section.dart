import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:flutter/material.dart';

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rankings = [
      {'name': 'Anjali Patel', 'points': 248, 'color': Colors.green},
      {'name': 'Rahul Kumar', 'points': 196, 'color': Colors.black},
      {'name': 'Vikram Singh', 'points': 156, 'color': Colors.black},
    ];

    return DashboardSection(
      title: 'Team Leaderboard',
      child: Column(
        children: [
          ...rankings.map(
            (r) => ListTile(
              leading: CircleAvatar(
                radius: 4,
                backgroundColor: r['color'] as Color,
              ),
              title: Text(
                r['name'] as String,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: context.scaleFont(16),
                  color: Color(0xFF101828),
                ),
              ),
              trailing: Text(
                '${r['points']} pts',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: r['color'] as Color,
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const CircleAvatar(
              radius: 4,
              backgroundColor: Colors.blue,
            ),
            title: Text(
              'You',
              style: TextStyle(
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '156 pts',
              style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: context.scaleFont(14),
                fontWeight: FontWeight.bold,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ],
      ),
    );
  }
}
