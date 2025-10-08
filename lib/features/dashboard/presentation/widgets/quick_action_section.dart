import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/action_button.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/service_request_form.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  void _showServiceRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: ServiceRequestForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      title: 'Quick Actions',
      child: Column(
        children: <Widget>[
          const ActionButton(
            title: 'Log Time Entry',
            icon: Icons.description_outlined,
          ),
          const ActionButton(
            title: 'View Team Tasks',
            icon: Icons.group_outlined,
          ),
          const ActionButton(title: 'Weekly Report', icon: Icons.bar_chart),

          ActionButton(
            title: 'Raise Service Request',
            icon: Icons.add_circle_outline,
            isPrimary: true,
            onTap: () => _showServiceRequestDialog(context),
          ),
        ],
      ),
    );
  }
}
