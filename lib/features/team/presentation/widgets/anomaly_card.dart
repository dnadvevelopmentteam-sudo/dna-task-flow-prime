import 'package:dna_taskflow_prime/features/team/data/models/anomalies_models.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/severity_tags.dart';
import 'package:flutter/material.dart';

class AnomalyCard extends StatelessWidget {
  final AnomalyEntry entry;
  const AnomalyCard({required this.entry, super.key});

  Color get borderColor {
    if (entry.status == AnomalyStatus.resolved) return Colors.green.shade200;
    switch (entry.severity) {
      case AnomalySeverity.high:
        return Colors.red.shade200;
      case AnomalySeverity.medium:
        return Colors.orange.shade200;
      case AnomalySeverity.low:
        return Colors.blue.shade200;
    }
  }

  Color get bgColor {
    if (entry.status == AnomalyStatus.resolved) return Colors.green.shade50;
    switch (entry.severity) {
      case AnomalySeverity.high:
        return Colors.red.shade50;
      case AnomalySeverity.medium:
        return Colors.orange.shade50;
      case AnomalySeverity.low:
        return Colors.blue.shade50;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildInitialsCircle(entry.initials),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${entry.team} • ${entry.date}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  if (entry.status == AnomalyStatus.open)
                    SeverityTag(severity: entry.severity),
                  if (entry.status == AnomalyStatus.open)
                    const SizedBox(width: 8),
                  StatusTag(status: entry.status, severity: entry.severity),
                ],
              ),
            ],
          ),
          const Divider(height: 30, color: Color(0xFFEAEAEA)),

          Text(
            entry.anomalyType,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            entry.description,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          const SizedBox(height: 15),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem('Task:', entry.task),
              _buildDetailItem('Client:', entry.client),
              _buildDetailItem('Duration:', entry.duration),
              _buildDetailItem('Detected:', entry.detectedDate),
            ],
          ),
          const SizedBox(height: 20),

          if (entry.status == AnomalyStatus.resolved)
            ResolutionBox(
              resolution: entry.resolution ?? 'No resolution provided',
            ),

          if (entry.status == AnomalyStatus.open)
            Row(
              children: entry.actions.map((action) {
                if (action == 'Investigate') {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InvestigateButton(onPressed: () {}),
                  );
                } else if (action == 'Mark Resolved') {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: MarkResolvedButton(onPressed: () {}),
                  );
                } else if (action == 'Add Note') {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: AddNoteButton(onPressed: () {}),
                  );
                }
                return const SizedBox.shrink();
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildInitialsCircle(String initials) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
