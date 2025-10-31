import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:dna_taskflow_prime/features/leaderboards/presentation/pages/leader_board_page.dart';
import 'package:flutter/material.dart';

import 'points_breakdown_dialog.dart';

class RankBadge extends StatelessWidget {
  final int rank;
  final Color color;
  final bool isYou;

  const RankBadge({
    super.key,
    required this.rank,
    required this.color,
    this.isYou = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: isYou ? Colors.blue.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: color, width: 1.5),
      ),
      child: Center(
        child: Text(
          '$rank',
          style: TextStyle(
            color: color,
            fontSize: context.scaleFont(12),
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

class LeaderboardSection extends StatelessWidget {
  const LeaderboardSection({super.key});

  final List<Map<String, dynamic>> allRankings = const [
    {'name': 'Anjali Patel', 'points': 248, 'isYou': false},
    {'name': 'Rahul Kumar', 'points': 196, 'isYou': false},
    {'name': 'Vikram Singh', 'points': 174, 'isYou': false},
    {'name': 'You', 'points': 156, 'isYou': true},
  ];

  void _navigateToProfile(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to $name\'s profile...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedRankings = List<Map<String, dynamic>>.from(allRankings)
      ..sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));

    Color getRankColor(int rank, bool isYou) {
      if (isYou) return AppColors.primary;
      switch (rank) {
        case 1:
          return Colors.green;
        case 2:
        case 3:
          return Color(0xFF808080);
        default:
          return AppColors.primary;
      }
    }

    final youData = sortedRankings.firstWhere((r) => r['isYou']);
    final youRank = sortedRankings.indexOf(youData) + 1;

    final List<Map<String, dynamic>> visualList = [
      {'name': 'Anjali Patel', 'points': 248, 'isYou': false, 'rank': 1},
      {'name': 'Rahul Kumar', 'points': 196, 'isYou': false, 'rank': 2},
      {'name': 'Vikram Singh', 'points': 174, 'isYou': false, 'rank': 3},
      {'name': 'You', 'points': 156, 'isYou': true, 'rank': youRank},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SizedBox(
      height: 300,
      child: DashboardSection(
        title: 'Team Leaderboard',
        child: Column(
          children: [
            ...visualList.sublist(0, 3).asMap().entries.map((entry) {
              final index = entry.key;
              final r = entry.value;
              final rank = index + 1;
              final name = r['name'] as String;
              final color = getRankColor(rank, r['isYou'] as bool);
              final pointsColor = rank == 1
                  ? Color(0xFF00A63E)
                  : const Color(0xFF101828);

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeaderBoardPage()),
                  );
                },
                leading: RankBadge(rank: rank, color: color),
                title: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: context.scaleFont(16),
                    color: const Color(0xFF101828),
                  ),
                ),
                trailing: Text(
                  '${r['points']} pts',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: pointsColor,
                    fontSize: context.scaleFont(16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                dense: true,
              );
            }),
            const Divider(height: 1),

            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return Dialog(
                    //   child: PointsBreakdownContent(isMobile: isMobile),
                    // );

                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: PointsBreakdownContent(isMobile: isMobile),
                    );
                  },
                );
              },
              leading: RankBadge(
                rank: youRank,
                color: AppColors.primary,
                isYou: true,
              ),
              title: Text(
                youData['name'] as String,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
              trailing: Text(
                '${youData['points']} pts',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: AppColors.primary,
                  fontSize: context.scaleFont(16),
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              // dense: true,
              // tileColor: Colors.blue.shade50,
            ),
          ],
        ),
      ),
    );
  }
}
