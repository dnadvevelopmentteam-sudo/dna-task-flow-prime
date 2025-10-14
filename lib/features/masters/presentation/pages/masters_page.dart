import 'package:dna_taskflow_prime/features/masters/data/models/master_module.dart';
import 'package:dna_taskflow_prime/features/masters/features/staff%20management/presentation/pages/staff_management_page.dart';
import 'package:flutter/material.dart';

void navigateTo(BuildContext context, String destination) {
  print('Navigating to: $destination');
}

class MetricItem {
  final String title;
  final String count;
  final IconData icon;
  final Color iconColor;
  final String status;

  MetricItem({
    required this.title,
    required this.count,
    required this.icon,
    required this.iconColor,
    this.status = '',
  });
}

final List<MasterModule> mockMasterModules = [
  MasterModule(
    title: "Staff Management",
    description: "Manage user accounts, roles, and permissions",
    count: "45",
    actionText: "Manage",
    icon: Icons.people_outline,
    iconColor: const Color(0xFF673AB7),
    destination: '',
    onTap: (context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StaffManagementScreen()),
      );
    },
  ),
  MasterModule(
    title: "Designations",
    description: "Manage job titles and organizational hierarchy",
    count: "18",
    actionText: "Manage",
    icon: Icons.calendar_view_month,
    iconColor: const Color(0xFF673AB7),
    destination: "Designations",
  ),
  MasterModule(
    title: "Client Assignments",
    description: "Assign employees to clients for task access",
    count: "24",
    actionText: "Manage",
    icon: Icons.person_add_alt_1_outlined,
    iconColor: const Color(0xFF00BCD4),
    destination: "ClientAssignments",
  ),
  MasterModule(
    title: "Teams & Departments",
    description: "Organize teams and departmental structures",
    count: "8",
    actionText: "Manage",
    icon: Icons.group_work_outlined,
    iconColor: const Color(0xFF4CAF50),
    destination: "TeamsDepartments",
  ),
  MasterModule(
    title: "Shift Patterns",
    description: "Define work schedules and shift rotations",
    count: "12",
    actionText: "Manage",
    icon: Icons.calendar_month_outlined,
    iconColor: const Color(0xFFE91E63),
    destination: "ShiftPatterns",
  ),
  MasterModule(
    title: "Holiday Calendars",
    description: "Manage public holidays and company observances",
    count: "24",
    actionText: "Manage",
    icon: Icons.calendar_today_outlined,
    iconColor: const Color(0xFFFF9800),
    destination: "HolidayCalendars",
  ),
  MasterModule(
    title: "System Tags",
    description: "Configure tags for categorization and filtering",
    count: "156",
    actionText: "Manage",
    icon: Icons.loyalty_outlined,
    iconColor: const Color(0xFF7B1FA2),
    destination: "SystemTags",
  ),
  MasterModule(
    title: "Capture Policies",
    description: "Set screenshot and tracking requirements",
    count: "6",
    actionText: "Manage",
    icon: Icons.gpp_good_outlined,
    iconColor: const Color(0xFFF44336),
    destination: "CapturePolicies",
  ),
  MasterModule(
    title: "Asset Management",
    description: "Track company equipment and resources",
    count: "89",
    actionText: "Manage",
    icon: Icons.storage_outlined,
    iconColor: const Color(0xFF03A9F4),
    destination: "AssetManagement",
  ),
  MasterModule(
    title: "Notice Settings",
    description: "Configure system-wide notifications and alerts",
    count: "12",
    actionText: "Manage",
    icon: Icons.notifications_none,
    iconColor: const Color(0xFFFFC107),
    destination: "NoticeSettings",
  ),
  MasterModule(
    title: "Shift Allocations",
    description: "Assign shifts to employees and manage schedules",
    count: "45",
    actionText: "Manage",
    icon: Icons.person_outline,
    iconColor: const Color(0xFF9C27B0),
    destination: "ShiftAllocations",
  ),
];

final List<MetricItem> mockMetricItems = [
  MetricItem(
    title: "Total Users",
    count: "45",
    icon: Icons.people_outline,
    iconColor: const Color(0xFF673AB7),
  ),
  MetricItem(
    title: "Active Teams",
    count: "8",
    icon: Icons.group_work_outlined,
    iconColor: const Color(0xFF4CAF50),
  ),
  MetricItem(
    title: "Active Policies",
    count: "6",
    icon: Icons.gpp_good_outlined,
    iconColor: const Color(0xFF7B1FA2),
  ),
  MetricItem(
    title: "System Health",
    count: "Good",
    icon: Icons.health_and_safety_outlined,
    iconColor: const Color(0xFFFF9800),
    status: 'Good',
  ),
];

class MastersPage extends StatelessWidget {
  const MastersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF3B82F6),
                    size: 30,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Masters Hub",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Configure and manage system-wide settings and data",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFF4A5565),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "11 Categories",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF4A5565),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          _buildModulesGrid(context),

          const SizedBox(height: 40),

          _buildMetricsGrid(context),
        ],
      ),
    );
  }

  Widget _buildModulesGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 800) {
      crossAxisCount = 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockMasterModules.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        return ModuleCard(module: mockMasterModules[index]);
      },
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 800) {
      crossAxisCount = 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockMetricItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 3.5,
      ),
      itemBuilder: (context, index) {
        return MetricCard(item: mockMetricItems[index]);
      },
    );
  }
}

class ModuleCard extends StatefulWidget {
  final MasterModule module;

  const ModuleCard({required this.module, super.key});

  @override
  State<ModuleCard> createState() => _ModuleCardState();
}

class _ModuleCardState extends State<ModuleCard> {
  bool _isHovering = false;

  void _handleTap() {
    if (widget.module.onTap != null) {
      widget.module.onTap!(context);
      return;
    }

    if (widget.module.destination.isNotEmpty) {
      navigateTo(context, widget.module.destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = _isHovering
        ? const Color(0xFF3B82F6)
        : const Color(0xFFD9D9D9);
    final Color cardColor = _isHovering
        ? const Color(0xFFEFF6FF)
        : const Color(0xFFFFFFFF);

    return InkWell(
      onTap: _handleTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: Card(
          color: cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.module.iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        widget.module.icon,
                        color: widget.module.iconColor,
                        size: 24,
                      ),
                    ),
                    _buildCountBadge(widget.module.count),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  widget.module.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                const SizedBox(height: 4),

                Expanded(
                  child: Text(
                    widget.module.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xFF4A5565),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 16),

                _buildActionButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountBadge(String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF222B45),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    final Color textColor = _isHovering
        ? const Color(0xFF3B82F6)
        : const Color(0xFF4A5565);
    final Color buttonBorderColor = _isHovering
        ? const Color(0xFF3B82F6)
        : const Color(0xFFD9D9D9);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _handleTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFFFFFFF),
          foregroundColor: textColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          side: BorderSide(color: buttonBorderColor, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(
          widget.module.actionText,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final MetricItem item;

  const MetricCard({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    Color statusColor = const Color(0xFF28A745);
    if (item.status.isEmpty) {
      statusColor = item.iconColor;
    }

    return Card(
      color: const Color(0xFFFFFFFF),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Icon(item.icon, color: statusColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF4A5565),
                  ),
                ),
              ],
            ),

            Text(
              item.count,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A0A0A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
