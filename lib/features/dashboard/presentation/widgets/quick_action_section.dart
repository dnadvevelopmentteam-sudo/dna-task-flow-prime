import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/action_button.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardSection(
      title: 'Quick Actions',
      child: Column(
        children: [
          ActionButton(
            title: 'Log Time Entry',
            icon: Icons.description_outlined,
          ),
          ActionButton(title: 'View Team Tasks', icon: Icons.group_outlined),
          ActionButton(title: 'Weekly Report', icon: Icons.bar_chart),
          ActionButton(
            title: 'Raise Service Request',
            icon: Icons.add_circle_outline,
            isPrimary: true,
          ),
        ],
      ),
    );
  }
}
