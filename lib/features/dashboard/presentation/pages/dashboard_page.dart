import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/Tasks/presentation/pages/tasks_page.dart';
import 'package:dna_taskflow_prime/features/clients/presentation/pages/clients_page.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/bottom_section_row.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/create_announcment_dialogbox.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/place_holder_page.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/recent_task_cards.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/side_bar.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/stats_row.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    MainDashboardContent(),
    TasksPage(),
    ClientsPage(),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.scaleFont(16),
                  ),
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
          icon: SizedBox(
            width: 36,
            height: 36,
            child: const ImageIcon(
              AssetImage('assets/icons/Bell.png'),
              // color: Colors.grey,
            ),
          ),
          onPressed: () {},
        ),
        if (isDesktop || context.screenWidth > 500) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFDBEAFE),
                    // radius:
                    // 20,
                    child: Text(
                      'DU',
                      style: TextStyle(
                        fontFamily: "Inter",
                        color: Color(0xFF0851B8),
                        fontSize: context.scaleFont(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  'Demo User',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF101828),
                    fontSize: context.scaleFont(16),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 9.0, left: 9.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Color(0xFFFB2C36),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'Admin',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFFFFFFFF),
                  fontSize: context.scaleFont(12),

                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// --- DASHBOARD CONTENT (Index 0) (Unchanged) ---
class MainDashboardContent extends StatelessWidget {
  MainDashboardContent({super.key});
  void _showCreateAnnouncement(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreateAnnouncementDialog();
      },
    );
  }

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
              onPressed: () {
                _showCreateAnnouncement(context);
              },
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
