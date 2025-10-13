import 'package:dna_taskflow_prime/features/team/presentation/widgets/analytics_content.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/anomalies_content.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/approvals_content.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/team_overview_content.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/time_sheets_content.dart';
import 'package:flutter/material.dart';

class TeamData {
  final String name;
  final String manager;
  final int members;
  final int activeMembers;
  final double efficiency;
  final double avgHours;
  final int pendingItems;

  TeamData({
    required this.name,
    required this.manager,
    required this.members,
    required this.activeMembers,
    required this.efficiency,
    required this.avgHours,
    required this.pendingItems,
  });
}

final List<TeamData> teams = [
  TeamData(
    name: 'Development Team',
    manager: 'John Smith',
    members: 8,
    activeMembers: 7,
    efficiency: 92,
    avgHours: 7.5,
    pendingItems: 3,
  ),
  TeamData(
    name: 'QA Team',
    manager: 'Sarah Johnson',
    members: 5,
    activeMembers: 5,
    efficiency: 88,
    avgHours: 8.1,
    pendingItems: 1,
  ),
  TeamData(
    name: 'Design Team',
    manager: 'Mike Davis',
    members: 4,
    activeMembers: 3,
    efficiency: 85,
    avgHours: 7.8,
    pendingItems: 2,
  ),
];

class TeamDashboardScreen extends StatefulWidget {
  const TeamDashboardScreen({super.key});

  @override
  State<TeamDashboardScreen> createState() => _TeamDashboardScreenState();
}

class _TeamDashboardScreenState extends State<TeamDashboardScreen> {
  final List<String> _tabs = [
    'Team Overview',
    'Analytics',
    'Timesheets',
    'Approvals',
    'Anomalies',
  ];
  String _selectedTab = 'Team Overview';

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 'Team Overview':
        return const TeamOverviewContent();
      case 'Analytics':
        return const AnalyticsContent();
      case 'Timesheets':
        return const TimesheetsContent();
      case 'Approvals':
        return const ApprovalsContent();
      case 'Anomalies':
        return const AnomaliesContent();
      default:
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 100),
          child: Text(
            'Content for $_selectedTab goes here (Different UI)',
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
        );
    }
  }

  Widget _buildTabButton(String tabName) {
    final isSelected = _selectedTab == tabName;

    final containerDecoration = BoxDecoration(
      color: isSelected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      border: isSelected
          ? Border.all(color: Colors.grey.shade300, width: 1.0)
          : null,
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tabName;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(right: 8),
        decoration: containerDecoration,
        child: Text(
          tabName,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: _tabs.map((tab) => _buildTabButton(tab)).toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 350,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search teams or managers...',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              _buildTabBar(),
              const SizedBox(height: 40),

              _buildTabContent(),
            ],
          ),
        ),
      ),
    );
  }
}
