import 'package:dna_taskflow_prime/features/team/presentation/pages/team_page.dart';
import 'package:flutter/material.dart';

class TeamOverviewContent extends StatelessWidget {
  const TeamOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: teams
          .map((team) => Expanded(child: TeamCard(team: team)))
          .toList(),
    );
  }
}

class TeamCard extends StatelessWidget {
  final TeamData team;
  const TeamCard({required this.team, super.key});

  Widget _buildStatLine(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  team.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${team.activeMembers}/${team.members} Active',
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            'Managed by ${team.manager}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const Divider(height: 25, color: Color(0xFFEAEAEA)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatLine(
                    Icons.group_outlined,
                    '${team.members} Members',
                  ),
                  _buildStatLine(
                    Icons.bar_chart_outlined,
                    '${team.efficiency}% Efficiency',
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatLine(Icons.schedule, '${team.avgHours}h Avg'),
                  _buildStatLine(
                    Icons.list_alt,
                    '${team.pendingItems} Pending',
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 25, color: Color(0xFFEAEAEA)),

          Center(
            child: SizedBox(
              height: 45,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 18,
                  color: Colors.black,
                ),
                label: const Text(
                  'View Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
