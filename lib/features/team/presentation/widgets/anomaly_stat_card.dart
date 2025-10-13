import 'package:dna_taskflow_prime/features/team/data/models/anomalies_models.dart';
import 'package:flutter/material.dart';

class AnomalyStatCard extends StatelessWidget {
  final AnomalyMetric stat;
  const AnomalyStatCard({super.key, required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stat.value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: stat.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.title,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
