import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/action_button.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/service_request_form.dart';
import 'package:dna_taskflow_prime/features/tasks/presentation/pages/tasks_page.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/analytics_content.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/pages/timesheet_team_page.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  void _showServiceRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: ServiceRequestForm(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      title: 'Quick Actions',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Column(
          children: <Widget>[
            ActionButton(
              title: 'Log Time Entry',
              icon: Icons.calendar_today_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimesheetTeamPage()),
                );
              },
            ),
            const SizedBox(height: 8),
            ActionButton(
              title: 'View Team Tasks',
              icon: Icons.group_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TasksPage()),
                );
              },
            ),
            const SizedBox(height: 8),
            ActionButton(
              title: 'Weekly Report',
              icon: Icons.auto_graph_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalyticsContent()),
                );
              },
            ),
            const SizedBox(height: 16),
            ActionButton(
              title: 'Raise Service Request',
              icon: Icons.headphones_outlined,
              isPrimary: true,
              onTap: () => _showServiceRequestDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}
