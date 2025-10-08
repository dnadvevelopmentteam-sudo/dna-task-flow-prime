import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/side_bar_menu_item.dart';
import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final Widget icon;
  const SidebarItem(this.title, this.icon);
}

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  Sidebar({super.key, required this.selectedIndex, required this.onItemTap});

  final List<SidebarItem> menuItems = [
    SidebarItem(
      'Dashboard',
      Image.asset('assets/icons/dashboard_icon.png', width: 24, height: 24),
    ),
    SidebarItem('Tasks', Image.asset('assets/icons/tasks_icon.png')),
    SidebarItem('Clients', Image.asset('assets/icons/clients_icon.png')),
    SidebarItem('Timesheet', Image.asset('assets/icons/timesheet_icon.png')),
    SidebarItem(
      'Timesheet-Team',
      Image.asset('assets/icons/timesheet_team_icon.png'),
    ),
    SidebarItem(
      'Recurring Tasks',
      Image.asset('assets/icons/recurring_tasks_icon.png'),
    ),
    SidebarItem(
      'Escalations',
      Image.asset('assets/icons/escalations_icon.png'),
    ),
    SidebarItem('Masters', Image.asset('assets/icons/masters_icon.png')),
    SidebarItem('Team', Image.asset('assets/icons/team_icon.png')),
    SidebarItem('Reports', Image.asset('assets/icons/reports_icon.png')),
    SidebarItem(
      'Leaderboards',
      Image.asset('assets/icons/leaderboards_icon.png'),
    ),
    SidebarItem('Notices', Image.asset('assets/icons/notices_icon.png')),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(
        color: Colors.white10,
        border: Border(right: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return SidebarMenuItem(
                  title: item.title,
                  icon: item.icon,
                  isSelected: index == selectedIndex,
                  onTap: () => onItemTap(index),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Icon(
                  Icons.settings_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 10),

                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: context.scaleFont(14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
