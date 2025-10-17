import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/active_tasks_dialog.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/stat_card.dart';
import 'package:flutter/material.dart';

import 'hours_logged_dialog.dart';
import 'overdue_taska_dialog.dart';
import 'points_breakdown_dialog.dart';

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  void _showActiveTasksDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.95 : 860,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: ActiveTasksDialog(isMobile: isMobile),
          ),
        );
      },
    );
  }

  void _showHoursLoggedDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.95 : 860,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: HoursLoggedDialog(isMobile: isMobile),
          ),
        );
      },
    );
  }

  void _showOverdueTasks(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.95 : 860,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: OverdueTasksDetailsContent(isMobile: isMobile),
          ),
        );
      },
    );
  }

  void _showPointsBreakdown(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? screenWidth * 0.95 : 860,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: PointsBreakdownContent(isMobile: isMobile),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    final cards = <Widget>[
      StatCard(
        title: 'Active Tasks',
        value: '24',
        subtitle: '3 due today',
        path: 'assets/icons/active.png',
        onTap: () {
          _showActiveTasksDialog(context);
        },
      ),
      StatCard(
        title: 'Hours Logged',
        value: '42.5',
        subtitle: 'This week',
        path: 'assets/icons/clock.png',
        onTap: () {
          _showHoursLoggedDialog(context);
        },
      ),
      StatCard(
        title: 'Overdue',
        value: '3',
        subtitle: 'Need attention',
        path: 'assets/icons/overdue.png',
        onTap: () {
          _showOverdueTasks(context);
        },
      ),
      StatCard(
        title: 'Points',
        value: '156',
        subtitle: 'Monthly rank #4',
        path: 'assets/icons/points.png',
        onTap: () {
          _showPointsBreakdown(context);
        },
      ),
    ];

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cards
            .map(
              (card) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: card,
              ),
            )
            .toList(),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards
            .map((card) => Expanded(child: card))
            .toList()
            .withSpacing(20),
      );
    }
  }
}
