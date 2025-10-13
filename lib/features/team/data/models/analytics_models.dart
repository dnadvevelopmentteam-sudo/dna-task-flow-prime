// --- DATA MODELS FOR ANALYTICS TAB ---

import 'package:flutter/material.dart';

class VarianceData {
  final String service;
  final String client;
  final int estimatedHours;
  final int actualHours;
  final int variance;

  VarianceData({
    required this.service,
    required this.client,
    required this.estimatedHours,
    required this.actualHours,
    required this.variance,
  });
}

class UtilizationData {
  final String service;
  final double percentage;
  final Color color;

  UtilizationData({
    required this.service,
    required this.percentage,
    required this.color,
  });
}

class FunnelData {
  final String stage;
  final int entries;
  final double percentage;

  FunnelData({
    required this.stage,
    required this.entries,
    required this.percentage,
  });
}

class DailyHoursData {
  final String day;
  final double target;
  final double actual;

  DailyHoursData({
    required this.day,
    required this.target,
    required this.actual,
  });
}

class CoverageData {
  final String range;
  final int count;
  final Color color;

  CoverageData({required this.range, required this.count, required this.color});
}

// --- STATIC DATA LISTS ---

final List<VarianceData> varianceData = [
  VarianceData(
    service: 'Development',
    client: 'Client A',
    estimatedHours: 120,
    actualHours: 135,
    variance: 15,
  ),
  VarianceData(
    service: 'QA Testing',
    client: 'Client B',
    estimatedHours: 80,
    actualHours: 75,
    variance: -5,
  ),
  VarianceData(
    service: 'Design',
    client: 'Client C',
    estimatedHours: 60,
    actualHours: 68,
    variance: 8,
  ),
];

final List<UtilizationData> utilizationData = [
  UtilizationData(
    service: 'Development',
    percentage: 45,
    color: const Color(0xFF3868EA),
  ),
  UtilizationData(
    service: 'QA Testing',
    percentage: 25,
    color: const Color(0xFF27AE60),
  ),
  UtilizationData(
    service: 'Design',
    percentage: 20,
    color: const Color(0xFFF39C12),
  ),
  UtilizationData(
    service: 'Documentation',
    percentage: 10,
    color: const Color(0xFF9B59B6),
  ),
];

final List<FunnelData> funnelData = [
  FunnelData(stage: 'Submitted', entries: 45, percentage: 1.00),
  FunnelData(stage: 'TM Review', entries: 38, percentage: 0.84),
  FunnelData(stage: 'GM Review', entries: 32, percentage: 0.71),
  FunnelData(stage: 'EP Approved', entries: 30, percentage: 0.67),
];

final List<DailyHoursData> dailyHoursData = [
  DailyHoursData(day: 'Mon', target: 8.0, actual: 7.5),
  DailyHoursData(day: 'Tue', target: 8.5, actual: 8.0),
  DailyHoursData(day: 'Wed', target: 8.0, actual: 7.8),
  DailyHoursData(day: 'Thu', target: 8.7, actual: 8.0),
  DailyHoursData(day: 'Fri', target: 8.0, actual: 7.7),
];

final List<CoverageData> coverageData = [
  CoverageData(range: '80-100%', count: 15, color: const Color(0xFF27AE60)),
  CoverageData(range: '50-80%', count: 8, color: const Color(0xFFF39C12)),
  CoverageData(range: '0-50%', count: 2, color: const Color(0xFFE74C3C)),
];
