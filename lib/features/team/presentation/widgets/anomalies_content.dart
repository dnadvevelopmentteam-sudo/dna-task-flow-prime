import 'package:dna_taskflow_prime/features/team/data/models/anomalies_models.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/anomaly_card.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/anomaly_stat_card.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/severity_tags.dart';
import 'package:flutter/material.dart';

class AnomaliesContent extends StatelessWidget {
  const AnomaliesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: anomalyMetrics
              .map((stat) => Expanded(child: AnomalyStatCard(stat: stat)))
              .toList(),
        ),
        const SizedBox(height: 30),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                'Severity',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              FilterDropdown(label: 'All Levels'),
              SizedBox(width: 30),
              Text(
                'Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              FilterDropdown(label: 'All Status'),
              SizedBox(width: 30),
              Text(
                'Type',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              FilterDropdown(label: 'All Types'),
            ],
          ),
        ),
        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.black,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Detected Anomalies (${anomalyEntries.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ExportListButton(onPressed: () {}),
            ],
          ),
        ),
        const SizedBox(height: 20),

        ...anomalyEntries.map((entry) => AnomalyCard(entry: entry)),
      ],
    );
  }
}
