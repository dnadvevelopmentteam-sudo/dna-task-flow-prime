import 'package:dna_taskflow_prime/features/leaderboards/presentation/widgets/leader_board_content.dart';
import 'package:flutter/material.dart';

class LeaderboardTabs extends StatelessWidget {
  const LeaderboardTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E0E0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            labelColor: const Color(0xFF333333),
            unselectedLabelColor: const Color(0xFF757575),
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 18),
                    SizedBox(width: 8),
                    Text('Staff Leaderboard'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.group, size: 18),
                    SizedBox(width: 8),
                    Text('Team Rankings'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        const Expanded(
          child: TabBarView(
            children: [
              LeaderboardContent(
                title: 'Staff Leaderboard',
                failureMessage:
                    'Failed to load leaderboard: Failed to fetch leaderboard',
              ),
              LeaderboardContent(
                title: 'Team Leaderboard',
                failureMessage:
                    'Failed to load team leaderboard: Failed to fetch team points',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
