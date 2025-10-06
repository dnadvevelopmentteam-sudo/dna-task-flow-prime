import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/side_bar_menu_item.dart';
import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final IconData icon;
  const SidebarItem(this.title, this.icon);
}

class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTap;

  const Sidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final List<SidebarItem> menuItems = const [
    SidebarItem('Dashboard', Icons.dashboard),
    SidebarItem('Tasks', Icons.task),
    SidebarItem('Clients', Icons.people_alt),
    SidebarItem('Timesheet', Icons.schedule),
    SidebarItem('Timesheet-Team', Icons.group),
    SidebarItem('Recurring Tasks', Icons.repeat),
    SidebarItem('Escalations', Icons.arrow_upward),
    SidebarItem('Masters', Icons.storage),
    SidebarItem('Team', Icons.diversity_3),
    SidebarItem('Reports', Icons.assessment),
    SidebarItem('Leaderboards', Icons.leaderboard),
    SidebarItem('Notices', Icons.campaign),
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
