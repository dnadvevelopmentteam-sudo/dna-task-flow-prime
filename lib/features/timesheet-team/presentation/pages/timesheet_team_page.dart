import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/charts_funnel_section.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/filters_section.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/leader_board_section.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/summary_cards.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/title_export.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/utilization_mix.dart';
import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF0D47A1);
const Color kCardBorderColor = Color(0xFFFFFFFF);
const Color kShortfallColor = Color(0xFFE57373);
const Color kOvertimeColor = Color(0xFF4CAF50);
const Color kBackgroundColor = Color(0xFFF5F5F5);
const Color kTextLightColor = Color(0xFF757575);

class TimesheetTeamPage extends StatelessWidget {
  const TimesheetTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTitleAndExport(),
            const SizedBox(height: 16),
            FiltersScreen(),
            const SizedBox(height: 24),

            buildSummaryCards(),
            const SizedBox(height: 30),

            buildChartsAndFunnelSection(),
            const SizedBox(height: 30),

            buildUtilizationMix(),
            const SizedBox(height: 30),
            buildLeaderboardSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
