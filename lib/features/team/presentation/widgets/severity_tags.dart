import 'package:dna_taskflow_prime/features/team/data/models/anomalies_models.dart';
import 'package:flutter/material.dart';

class SeverityTag extends StatelessWidget {
  final AnomalySeverity severity;
  const SeverityTag({super.key, required this.severity});

  Color get color {
    switch (severity) {
      case AnomalySeverity.high:
        return Colors.red.shade700;
      case AnomalySeverity.medium:
        return Colors.orange.shade700;
      case AnomalySeverity.low:
        return Colors.blue.shade700;
    }
  }

  String get text {
    switch (severity) {
      case AnomalySeverity.high:
        return 'HIGH';
      case AnomalySeverity.medium:
        return 'MEDIUM';
      case AnomalySeverity.low:
        return 'LOW';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class StatusTag extends StatelessWidget {
  final AnomalyStatus status;
  final AnomalySeverity severity;
  const StatusTag({super.key, required this.status, required this.severity});

  Color get color {
    return status == AnomalyStatus.resolved
        ? Colors.green.shade700
        : Colors.red.shade700;
  }

  String get text {
    return status == AnomalyStatus.resolved ? 'Resolved' : 'Open';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ResolutionBox extends StatelessWidget {
  final String resolution;
  const ResolutionBox({super.key, required this.resolution});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        'Resolution: $resolution',
        style: TextStyle(
          color: Colors.green.shade800,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  final String label;
  const FilterDropdown({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black),
        ],
      ),
    );
  }
}

class ExportListButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ExportListButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.file_upload_outlined,
        size: 18,
        color: Colors.black,
      ),
      label: const Text(
        'Export List',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }
}

class InvestigateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const InvestigateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text(
        'Investigate',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MarkResolvedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MarkResolvedButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade400, width: 1),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: const Text(
        'Mark Resolved',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class AddNoteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddNoteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: const Text(
        'Add Note',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
