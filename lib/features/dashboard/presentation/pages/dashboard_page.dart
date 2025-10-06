import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/kanbancolumn_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/domain/entities/task_entity.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/bottom_section_row.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/place_holder_page.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/recent_task_cards.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/side_bar.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/stats_row.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/task_kanban_screen.dart';
import 'package:flutter/material.dart';

List<KanbanColumnEntity> initialKanbanData = [
  KanbanColumnEntity(
    title: 'To Do',
    status: 'todo',
    tasks: [
      TaskEntity(
        id: 'task-1',
        title: 'Urgent Tax Notice Response',
        company: 'Tech Innovations Pvt Ltd',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 46d 22h',
        loggedTime: '6h',
        assignees: 2,
        statusLabel: 'ToDo',
      ),
      TaskEntity(
        id: 'task-2',
        title: 'GSTR-3B Preparation',
        company: 'Green Energy Solutions',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 43d 22h',
        loggedTime: '2h',
        assignees: 2,
        statusLabel: 'ToDo',
      ),
    ],
    color: Colors.red.shade100,
  ),
  KanbanColumnEntity(
    title: 'In Progress',
    status: 'in_progress',
    tasks: [
      TaskEntity(
        id: 'task-3',
        title: 'ESI Return Filing',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 44d 22h',
        loggedTime: '3h',
        assignees: 1,
        statusLabel: 'Doing',
      ),
      TaskEntity(
        id: 'task-4',
        title: 'Audit Trail Documentation',
        company: 'Healthcare Associates',
        priority: 'Medium',
        priorityColor: Colors.amber.shade700,
        overdue: 'Overdue 42d 22h',
        loggedTime: '3h',
        assignees: 1,
        statusLabel: 'Doing',
      ),
    ],
    color: Colors.yellow.shade100,
  ),
  KanbanColumnEntity(
    title: 'Done',
    status: 'done',
    tasks: [
      TaskEntity(
        id: 'task-5',
        title: 'Client Onboarding - New Entity',
        company: 'Export Trading Co',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 34d 22h',
        loggedTime: '20h',
        assignees: 0,
        statusLabel: 'Done',
      ),
    ],
    color: Colors.green.shade100,
  ),
  KanbanColumnEntity(
    title: 'Review (TM)',
    status: 'review_tm',
    tasks: [
      TaskEntity(
        id: 'task-6',
        title: 'Payroll Reconciliation',
        company: 'Mumbai Retail Chain',
        priority: 'High',
        priorityColor: Colors.red.shade700,
        overdue: 'Overdue 39d 22h',
        loggedTime: '12h',
        assignees: 0,
        statusLabel: 'Review TM',
      ),
    ],
    color: Colors.blue.shade100,
  ),
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MainDashboardContent(),
    TaskKanbanScreen(),
    PlaceholderPage(title: 'Clients'),
    PlaceholderPage(title: 'Timesheet'),
    PlaceholderPage(title: 'Timesheet-Team'),
    PlaceholderPage(title: 'Recurring Tasks'),
    PlaceholderPage(title: 'Escalations'),
    PlaceholderPage(title: 'Masters'),
    PlaceholderPage(title: 'Team'),
    PlaceholderPage(title: 'Reports'),
    PlaceholderPage(title: 'Leaderboards'),
    PlaceholderPage(title: 'Notices'),
  ];

  void _onMenuItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (context.isDrawerMode) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = !context.isDrawerMode;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: isDesktop
          ? null
          : Drawer(
              child: Sidebar(
                selectedIndex: _selectedIndex,
                onItemTap: _onMenuItemSelected,
              ),
            ),
      body: Row(
        children: <Widget>[
          // Only show Sidebar inline on desktop
          if (isDesktop)
            Sidebar(
              selectedIndex: _selectedIndex,
              onItemTap: _onMenuItemSelected,
            ),

          // Right Partition: Dynamic Content Area
          Expanded(
            child: Column(
              children: [
                _buildCustomAppBar(isDesktop, context),
                Divider(),
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                    child: _pages[_selectedIndex],
                  ),
                ),
              ],
            ), // Display the selected page
          ),
        ],
      ),
    );
  }

  // A simplified App Bar for the top controls and search box
  PreferredSizeWidget _buildCustomAppBar(bool isDesktop, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,

      elevation: 10,

      // toolbarHeight: 60,
      // Add a leading menu icon on mobile to open the Drawer
      leading: !isDesktop
          ? Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.grey),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
      title: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 12,
                child: Text(
                  'd',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dnA Consulting',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: context.scaleFont(16),
                      fontWeight: FontWeight.w400,
                      color: Color(0xff101828),
                    ),
                  ),
                  Text(
                    'Task Management',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: context.scaleFont(12),
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6A7282),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Container(
            // Reduce search bar width/padding on smaller screens
            width: isDesktop ? 400 : 200,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F3F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search tasks, clients, or colleagues...',
                hintStyle: TextStyle(
                  fontSize: context.scaleFont(14), // Scaled font
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          Spacer(),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.grey),
          onPressed: () {},
        ),
        // Hide person icon on small mobile screens
        if (isDesktop || context.screenWidth > 500) ...[
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ],
    );
  }
}

// --- DASHBOARD CONTENT (Index 0) (Unchanged) ---
class MainDashboardContent extends StatelessWidget {
  MainDashboardContent({super.key});
  List<Map<String, dynamic>> recents = [
    {
      'title': 'GSTR-1 Filing for Acme Corp',
      'client': 'Acme Corporation',
      'priority': 'High',
      'overdue': '412d 17h',
      'assignee': 'Priya Sharma',
      'status': 'Doing',
      'hours': '4h',
      'comments': 3,
    },
    {
      'title': 'Income Tax Return - Q2 Review',
      'client': 'Tech Solutions Ltd',
      'priority': 'Medium',
      'overdue': '410d 17h',
      'assignee': 'Rahul Kumar',
      'status': 'ToDo',
      'hours': '6h',
      'comments': 1,
    },
    {
      'title': 'TDS Compliance Check',
      'client': 'Manufacturing Co',
      'priority': 'High',
      'overdue': '414d 17h',
      'assignee': 'Anjali Patel',
      'status': 'Doing',
      'hours': '3h',
      'comments': 5,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Good morning, Priya!',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: context.scaleFont(24),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0A0A0A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Here's what's happening with your tasks today.",
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: context.scaleFont(14),
              color: Color(0xFF4A5565),
            ),
          ),
          const SizedBox(height: 30),
          const StatsRow(),
          const SizedBox(height: 30),
          const BottomSectionsRow(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Create Announcement'),
              icon: const Icon(Icons.add, size: 20),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),

                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),

                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ListView.builder(
            shrinkWrap: true,
            itemCount: recents.length,
            itemBuilder: (context, index) =>
                RecentTaskCard(data: recents[index]),
          ),
        ],
      ),
    );
  }
}
