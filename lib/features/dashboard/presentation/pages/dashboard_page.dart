import 'package:dna_taskflow_prime/core/enums/quick_action_enum.dart';
import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:dna_taskflow_prime/features/clients/presentation/pages/clients_page.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/create_announcment_dialogbox.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/place_holder_page.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/recent_task_cards.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/side_bar.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/stats_row.dart'
    hide AppColors;
import 'package:dna_taskflow_prime/features/escalations/presentation/pages/escalations_page.dart';
import 'package:dna_taskflow_prime/features/leaderboards/presentation/pages/leader_board_page.dart';
import 'package:dna_taskflow_prime/features/masters/presentation/pages/masters_page.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/pages/notices_page.dart';
import 'package:dna_taskflow_prime/features/tasks/presentation/pages/tasks_page.dart';
import 'package:dna_taskflow_prime/features/team/presentation/pages/team_page.dart';
import 'package:dna_taskflow_prime/features/timesheet-team/presentation/pages/timesheet_team_page.dart';
import 'package:dna_taskflow_prime/features/timesheet/presentation/pages/time_sheet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../settings/presentation/pages/settings_page.dart';
import '../widgets/leadboard_section.dart';
import '../widgets/my_assest_section.dart';
import '../widgets/quick_action_section.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _pages = [
    MainDashboardContent(),
    TasksPage(),
    ClientsPage(),
    TimeSheetPage(),
    TimesheetTeamPage(),
    PlaceholderPage(title: 'Recurring Tasks'),
    EscalationsScreen(),
    MastersPage(),
    TeamDashboardScreen(),
    PlaceholderPage(title: 'Reports'),
    LeaderBoardPage(),
    NoticeBoardScreen(),
    SettingsContentArea(),
  ];

  void _onMenuItemSelected(int index) {
    dashboardBloc.add(TabUpdateEvent(selectedIndex: index));
    if (context.isDrawerMode) {
      Navigator.of(context).pop();
    }
  }

  late DashboardBloc dashboardBloc;

  @override
  void initState() {
    super.initState();
    dashboardBloc = BlocProvider.of<DashboardBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = !context.isDrawerMode;

    return BlocBuilder(
      bloc: dashboardBloc,
      builder: (context, state) {
        if (state is UpdatedTabIndex) {
          return Scaffold(
            backgroundColor: Colors.white,
            drawer: isDesktop
                ? null
                : Drawer(
                    child: Sidebar(
                      selectedIndex: state.index,
                      onItemTap: _onMenuItemSelected,
                    ),
                  ),
            body: Row(
              children: <Widget>[
                if (isDesktop)
                  Sidebar(
                    selectedIndex: state.index,
                    onItemTap: _onMenuItemSelected,
                  ),

                Expanded(
                  child: Column(
                    children: [
                      _buildCustomAppBar(isDesktop, context),
                      Divider(),
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.white),
                          child: _pages[state.index],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }

  PreferredSizeWidget _buildCustomAppBar(bool isDesktop, BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,

      elevation: 10,

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
              Image.asset('assets/appbar_logo.png', width: 32, height: 32),
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
                  fontSize: context.scaleFont(14),
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
            child: const ImageIcon(AssetImage('assets/icons/Bell.png')),
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
                        color: AppColors.primary,
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: AppColors.error,

                borderRadius: BorderRadius.circular(30.0),
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
    bool isMobile = context.isMobile;
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
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                LeaderboardSection(),
                SizedBox(height: 20),
                QuickActionsSection(
                  onTap: (p0) => {},
                  // onTap: (p0) {
                  //   switch (p0) {
                  //     case QuickActionEnum.log_entry:
                  //       BlocProvider.of<DashboardBloc>(
                  //         context,
                  //       ).add(TabUpdateEvent(selectedIndex: 3));
                  //       break;
                  //     case QuickActionEnum.weelkly_report:
                  //       BlocProvider.of<DashboardBloc>(
                  //         context,
                  //       ).add(TabUpdateEvent(selectedIndex: 1));
                  //       break;
                  //     case QuickActionEnum.view_team_tasks:
                  //       BlocProvider.of<DashboardBloc>(
                  //         context,
                  //       ).add(TabUpdateEvent(selectedIndex: 1));
                  //       break;
                  //   }
                  // },
                ),
                SizedBox(height: 20),
                MyAssetsSection(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(flex: 2, child: LeaderboardSection()),
                SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: QuickActionsSection(
                    onTap: (p0) {
                      switch (p0) {
                        case QuickActionEnum.log_entry:
                          BlocProvider.of<DashboardBloc>(
                            context,
                          ).add(TabUpdateEvent(selectedIndex: 3));
                          break;
                        case QuickActionEnum.weelkly_report:
                          BlocProvider.of<DashboardBloc>(
                            context,
                          ).add(TabUpdateEvent(selectedIndex: 1));
                          break;
                        case QuickActionEnum.view_team_tasks:
                          BlocProvider.of<DashboardBloc>(
                            context,
                          ).add(TabUpdateEvent(selectedIndex: 1));
                          break;
                      }
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(flex: 2, child: MyAssetsSection()),
              ],
            ),

          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  color: const Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Color(0xFFE0E0E0),
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'My Recent Tasks',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: recents.length,
                            itemBuilder: (context, index) =>
                                RecentTaskCard(data: recents[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 200),
              SizedBox(
                // width: 198,
                // height: 64,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _showCreateAnnouncement(context);
                  },
                  label: const Text('Create Announcement'),
                  icon: const Icon(Icons.add, size: 20),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
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
            ],
          ),
        ],
      ),
    );
  }
}
