import 'package:dna_taskflow_prime/features/timesheet-team/data/models/summary_card_data_model.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/widgets/chart_table_toggle.dart';
import 'package:flutter/material.dart';

final List<SummaryCardData> summaryData = [
  SummaryCardData(
    title: 'Total Hours',
    value: '0.0h',
    description: 'This period',
    icon: Icons.access_time_outlined,
  ),
  SummaryCardData(
    title: 'Avg Hours/Day',
    value: '0.0',
    description: '',
    icon: Icons.settings_input_component,
    indicator: Container(height: 5, color: const Color(0xFFF0F0F0)),
  ),
  SummaryCardData(
    title: 'Days ≥ 8h',
    value: '0%',
    description: 'Target compliance',
    icon: Icons.check_circle_outline,
    iconColor: const Color(0xFF4CAF50),
    indicator: Container(height: 5, color: const Color(0xFFF0F0F0)),
  ),
  SummaryCardData(
    title: 'Screenshot Coverage',
    value: '0%',
    description: '',
    icon: Icons.show_chart_outlined,
    indicator: Container(height: 5, color: const Color(0xFFF0F0F0)),
  ),
  SummaryCardData(
    title: 'On-time Completion',
    value: '0%',
    description: 'Task completion',
    icon: Icons.trending_up,
    indicator: Container(height: 5, color: const Color(0xFFF0F0F0)),
  ),
];

Widget buildSummaryCards() {
  return Column(
    children: [
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: summaryData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return _summaryCard(summaryData[index]);
        },
      ),
      const SizedBox(height: 20),

      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [ChartTableToggle()],
      ),
    ],
  );
}

Widget _summaryCard(SummaryCardData data) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
      border: Border.all(color: Colors.grey.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Color(0xFF0A0A0A),
                fontWeight: FontWeight.w400,
              ),
            ),

            Icon(
              data.icon,
              size: 16,
              color: data.iconColor ?? Colors.grey.shade700,
            ),
          ],
        ),

        Text(
          data.value,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            color: Color(0xFF0A0A0A),
            fontWeight: FontWeight.w600,
          ),
        ),

        if (data.indicator != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: data.indicator,
          )
        else
          Text(
            data.description,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B6B6B),
            ),
          ),
      ],
    ),
  );
}
