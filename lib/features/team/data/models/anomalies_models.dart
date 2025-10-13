import 'package:flutter/material.dart';

// --- ENUMS ---
enum AnomalySeverity { high, medium, low }

enum AnomalyStatus { open, resolved }

// --- MODELS ---

class AnomalyMetric {
  final String title;
  final String value;
  final Color color;

  AnomalyMetric({
    required this.title,
    required this.value,
    required this.color,
  });
}

class AnomalyEntry {
  final String initials;
  final String name;
  final String team;
  final String date;
  final String anomalyType;
  final String description;
  final String task;
  final String client;
  final String duration;
  final String detectedDate;
  final AnomalySeverity severity;
  final AnomalyStatus status;
  final String? resolution; // Nullable for 'Open' anomalies
  final List<String> actions;

  AnomalyEntry({
    required this.initials,
    required this.name,
    required this.team,
    required this.date,
    required this.anomalyType,
    required this.description,
    required this.task,
    required this.client,
    required this.duration,
    required this.detectedDate,
    required this.severity,
    required this.status,
    this.resolution,
    required this.actions,
  });
}

// --- STATIC DATA ---

final List<AnomalyMetric> anomalyMetrics = [
  AnomalyMetric(title: 'Total', value: '4', color: Colors.black),
  AnomalyMetric(title: 'Resolved', value: '2', color: Colors.green),
  AnomalyMetric(title: 'High', value: '1', color: Colors.red),
  AnomalyMetric(title: 'Medium', value: '2', color: Colors.orange),
  AnomalyMetric(title: 'Low', value: '1', color: Colors.blue),
];

final List<AnomalyEntry> anomalyEntries = [
  // 1. HIGH / OPEN Anomaly (Entry Without Screenshots)
  AnomalyEntry(
    initials: 'JD',
    name: 'John Doe',
    team: 'Development Team',
    date: '15/01/2024',
    anomalyType: 'Entry Without Screenshots',
    description:
        'Time entry recorded but no screenshots captured during work period',
    task: 'PROJ-123',
    client: 'Client A',
    duration: '8h',
    detectedDate: '15/01/2024',
    severity: AnomalySeverity.high,
    status: AnomalyStatus.open,
    resolution: null,
    actions: ['Investigate', 'Mark Resolved', 'Add Note'],
  ),
  // 2. MEDIUM / RESOLVED Anomaly (Low Coverage)
  AnomalyEntry(
    initials: 'JS',
    name: 'Jane Smith',
    team: 'Development Team',
    date: '14/01/2024',
    anomalyType: 'Low Coverage',
    description:
        'Screenshot coverage below minimum threshold (15% vs required 60%)',
    task: 'PROJ-124',
    client: 'Client B',
    duration: '7h',
    detectedDate: '14/01/2024',
    severity: AnomalySeverity.medium,
    status: AnomalyStatus.resolved,
    resolution: 'Justified due to client meeting and documentation work',
    actions: [],
  ),
  // 3. MEDIUM / OPEN Anomaly (Screenshots Without Entry)
  AnomalyEntry(
    initials: 'BW',
    name: 'Bob Wilson',
    team: 'QA Team',
    date: '13/01/2024',
    anomalyType: 'Screenshots Without Entry',
    description:
        'Screenshots detected during work hours but no timesheet entry recorded',
    task: 'Unknown',
    client: 'Unknown',
    duration: '2.5h',
    detectedDate: '13/01/2024',
    severity: AnomalySeverity.medium,
    status: AnomalyStatus.open,
    resolution: null,
    actions: ['Investigate', 'Mark Resolved', 'Add Note'],
  ),
  // 4. LOW / RESOLVED Anomaly (Time Variance)
  AnomalyEntry(
    initials: 'JD',
    name: 'John Doe',
    team: 'Development Team',
    date: '12/01/2024',
    anomalyType: 'Time Variance',
    description:
        'Actual time (10.5h) significantly exceeds estimated time (8h)',
    task: 'PROJ-126',
    client: 'Client C',
    duration: '10.5h',
    detectedDate: '13/01/2024',
    severity: AnomalySeverity.low,
    status: AnomalyStatus.resolved,
    resolution: 'Complex debugging required additional time',
    actions: [],
  ),
];
