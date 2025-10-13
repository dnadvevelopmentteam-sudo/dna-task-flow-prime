import 'package:dna_taskflow_prime/features/leaderboards/presentation/widgets/metric_card.dart';
import 'package:flutter/material.dart';

class MetricCardsRow extends StatelessWidget {
  const MetricCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: MetricCard(
            title: 'Top Performer',
            valueLine1: 'Sarah Johnson',
            valueLine2: '285 points this month',
            icon: Icons.emoji_events,
            iconColor: Color(0xFFFFD700),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: MetricCard(
            title: 'Top Team',
            valueLine1: 'Alpha Team',
            valueLine2: '1,240 points this month',
            icon: Icons.people,
            iconColor: Color(0xFF42A5F5),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: MetricCard(
            title: 'Monthly Growth',
            valueLine1: '+18.5%',
            valueLine2: 'vs last month',
            icon: Icons.trending_up,
            iconColor: Color(0xFF66BB6A),
            iconIsTrailing: true,
          ),
        ),
      ],
    );
  }
}
