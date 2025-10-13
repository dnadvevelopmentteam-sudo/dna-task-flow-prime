import 'package:dna_taskflow_prime/features/leaderboards/presentation/widgets/header_section.dart';
import 'package:dna_taskflow_prime/features/leaderboards/presentation/widgets/leader_board_tabs.dart';
import 'package:dna_taskflow_prime/features/leaderboards/presentation/widgets/metric_cards_row.dart';
import 'package:flutter/material.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),

        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(),
              SizedBox(height: 25),
              MetricCardsRow(),
              SizedBox(height: 30),
              Expanded(child: LeaderboardTabs()),
            ],
          ),
        ),
      ),
    );
  }
}
