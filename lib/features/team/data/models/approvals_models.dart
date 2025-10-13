import 'package:flutter/material.dart';

// --- MODELS ---

class MetricStat {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color baseColor;

  MetricStat({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.baseColor,
  });
}

class ApprovalRequest {
  final String initials;
  final String name;
  final String submissionDate;
  final String task;
  final String client;
  final String duration;
  final String daysPending;
  final int targetDays;
  final String pendingAt;
  final bool canEscalate;

  ApprovalRequest({
    required this.initials,
    required this.name,
    required this.submissionDate,
    required this.task,
    required this.client,
    required this.duration,
    required this.daysPending,
    required this.targetDays,
    required this.pendingAt,
    this.canEscalate = false,
  });
}

class BounceEntry {
  final String initials;
  final String name;
  final String submissionDate;
  final String task;
  final String client;
  final String lastBounceDate;
  final int bounces;
  final String latestIssue;
  final List<String> bounceHistory;

  BounceEntry({
    required this.initials,
    required this.name,
    required this.submissionDate,
    required this.task,
    required this.client,
    required this.lastBounceDate,
    required this.bounces,
    required this.latestIssue,
    required this.bounceHistory,
  });
}

// --- STATIC DATA ---

final List<MetricStat> metrics = [
  MetricStat(
    title: 'Overdue Approvals',
    value: '3',
    icon: Icons.access_time_filled,
    iconColor: Colors.deepOrange,
    baseColor: Colors.deepOrange.shade100,
  ),
  MetricStat(
    title: 'Repeated Bounces',
    value: '2',
    icon: Icons.repeat_rounded,
    iconColor: Colors.red,
    baseColor: Colors.red.shade100,
  ),
  MetricStat(
    title: 'Avg Days to Approve',
    value: '2.3',
    icon: Icons.show_chart,
    iconColor: Colors.blue.shade700,
    baseColor: Colors.blue.shade100,
  ),
  MetricStat(
    title: 'Need Escalation',
    value: '2',
    icon: Icons.error_outline,
    iconColor: Colors.purple,
    baseColor: Colors.purple.shade100,
  ),
];

final List<ApprovalRequest> pendingApprovals = [
  ApprovalRequest(
    initials: 'JD',
    name: 'John Doe',
    submissionDate: '10/01/2024',
    task: 'PROJ-123',
    client: 'Client A',
    duration: '8h',
    daysPending: '5 days',
    targetDays: 2,
    pendingAt: 'Technical Manager',
    canEscalate: true,
  ),
  ApprovalRequest(
    initials: 'JS',
    name: 'Jane Smith',
    submissionDate: '12/01/2024',
    task: 'PROJ-124',
    client: 'Client B',
    duration: '7.5h',
    daysPending: '3 days',
    targetDays: 1,
    pendingAt: 'General Manager',
    canEscalate: true,
  ),
  ApprovalRequest(
    initials: 'BW',
    name: 'Bob Wilson',
    submissionDate: '13/01/2024',
    task: 'PROJ-125',
    client: 'Client A',
    duration: '9h',
    daysPending: '2 days',
    targetDays: 3,
    pendingAt: 'Engagement Partner',
    canEscalate: false,
  ),
];

final List<BounceEntry> bouncedEntries = [
  BounceEntry(
    initials: 'AB',
    name: 'Alice Brown',
    submissionDate: '08/01/2024',
    task: 'PROJ-126',
    client: 'Client C',
    lastBounceDate: '14/01/2024',
    bounces: 4,
    latestIssue: 'Insufficient screenshot coverage',
    bounceHistory: ['TM #1', 'GM #2', 'TM #3', 'GM #4'],
  ),
  BounceEntry(
    initials: 'DM',
    name: 'David Miller',
    submissionDate: '11/01/2024',
    task: 'PROJ-127',
    client: 'Client B',
    lastBounceDate: '15/01/2024',
    bounces: 3,
    latestIssue: 'Missing task description',
    bounceHistory: ['TM #1', 'TM #2', 'TM #3'],
  ),
];
