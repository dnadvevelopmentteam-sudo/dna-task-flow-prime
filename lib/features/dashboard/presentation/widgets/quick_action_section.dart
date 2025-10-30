import 'package:dna_taskflow_prime/core/enums/quick_action_enum.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/action_button.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/add_time_entry_dialog.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/service_request_form.dart';
import 'package:flutter/material.dart';

import 'organization_analytics_screen.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key, required this.onTap});
  final Function(QuickActionEnum) onTap;
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

  void _logTimeEntry(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: AddTimeEntryDialog(),
          ),
        );
      },
    );
  }

  void _weeklyReport(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OrganizationAnalyticsDashboard();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: DashboardSection(
        title: 'Quick Actions',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: <Widget>[
              // ActionButton(
              //   title: 'Log Time Entry',
              //   icon: Icons.calendar_today_outlined,
              //   onTap: () {
              //     onTap(QuickActionEnum.log_entry);
              //   },
              // ),
              ActionButton(
                title: 'Log Time Entry',
                icon: Icons.headphones_outlined,
                // isPrimary: true,
                onTap: () => _logTimeEntry(context),
              ),

              const SizedBox(height: 8),
              ActionButton(
                title: 'View Team Tasks',
                icon: Icons.group_outlined,
                onTap: () {
                  onTap(QuickActionEnum.view_team_tasks);
                },
              ),
              const SizedBox(height: 8),

              // ActionButton(
              //   title: 'Weekly Report',
              //   icon: Icons.auto_graph_outlined,
              //   onTap: () {
              //     onTap(QuickActionEnum.weelkly_report);
              //   },
              // ),
              ActionButton(
                title: 'Weekly Report',
                icon: Icons.auto_graph_outlined,
                // isPrimary: true,
                onTap: () => _weeklyReport(context),
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
      ),
    );
  }
}
