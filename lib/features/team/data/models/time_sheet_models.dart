enum TimesheetStatus { approved, pending, changesRequested }

enum EntryType { timer, manual }

class TimeEntry {
  final String initials;
  final String name;
  final String team;
  final String date;
  final String client;
  final String project;
  final String service;
  final String timeRange;
  final String duration;
  final String remark;
  final double coverage;
  final TimesheetStatus status;
  final EntryType type;

  TimeEntry({
    required this.initials,
    required this.name,
    required this.team,
    required this.date,
    required this.client,
    required this.project,
    required this.service,
    required this.timeRange,
    required this.duration,
    required this.remark,
    required this.coverage,
    required this.status,
    required this.type,
  });
}

final List<TimeEntry> timeEntries = [
  TimeEntry(
    initials: 'JD',
    name: 'John Doe',
    team: 'Development Team',
    date: '15/01/2024',
    client: 'Client A',
    project: 'PROJ-123: Frontend component development',
    service: 'Service: Development',
    timeRange: '09:00 - 17:00',
    duration: '8h',
    remark: 'Completed user authentication module',
    coverage: 85,
    status: TimesheetStatus.approved,
    type: EntryType.timer,
  ),
  TimeEntry(
    initials: 'JS',
    name: 'Jane Smith',
    team: 'Development Team',
    date: '15/01/2024',
    client: 'Client B',
    project: 'PROJ-124: API integration testing',
    service: 'Service: Testing',
    timeRange: '10:00 - 17:00',
    duration: '7h',
    remark: 'Found and fixed 3 API issues',
    coverage: 92,
    status: TimesheetStatus.pending,
    type: EntryType.manual,
  ),
  TimeEntry(
    initials: 'BW',
    name: 'Bob Wilson',
    team: 'QA Team',
    date: '14/01/2024',
    client: 'Client A',
    project: 'PROJ-125: Automated test suite setup',
    service: 'Service: QA Testing',
    timeRange: '09:00 - 17:30',
    duration: '8h 30m',
    remark: 'Setup selenium test framework',
    coverage: 78,
    status: TimesheetStatus.changesRequested,
    type: EntryType.timer,
  ),
];
