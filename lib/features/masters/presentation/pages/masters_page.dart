import 'package:flutter/material.dart';

class MasterModule {
  final String title;
  final String description;
  final String count;
  final String actionText;
  final bool isLowCoverage;
  final bool hasStatusDot;
  final IconData? icon;

  MasterModule({
    required this.title,
    required this.description,
    required this.count,
    required this.actionText,
    this.isLowCoverage = false,
    this.hasStatusDot = true,
    this.icon,
  });
}

class MetricItem {
  final String title;
  final String count;

  MetricItem({required this.title, required this.count});
}

final List<MasterModule> mockMasterModules = List.generate(12, (index) {
  return MasterModule(
    title: "Staff Management",
    description: "Manage user accounts, roles, and permissions",
    count: "45",
    actionText: "Low Coverage",
    isLowCoverage: true,
  );
});

final List<MetricItem> mockMetricItems = List.generate(4, (index) {
  return MetricItem(title: "Total Users", count: "45");
});

class MastersPage extends StatelessWidget {
  const MastersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        return ModuleCard(
          module: mockMasterModules[index],
          onActionPressed: () {},
        );
      },
    );
  }

  Widget _buildMetricsGrid(BuildContext context) {
    // Determine the number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2; // Default for smaller screens
    if (screenWidth > 1200) {
      crossAxisCount = 4; // Desktop
    } else if (screenWidth > 800) {
      crossAxisCount = 3; // Tablet
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: mockMetricItems.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 3.5, // Taller aspect ratio for smaller card
      ),
      itemBuilder: (context, index) {
        return MetricCard(item: mockMetricItems[index]);
      },
    );
  }
}

class ModuleCard extends StatelessWidget {
  final MasterModule module;
  final VoidCallback onActionPressed;

  const ModuleCard({
    required this.module,
    required this.onActionPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFD9D9D9), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (module.hasStatusDot)
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Color(0xFFD9D9D9),
                        ),
                      ),
                    Text(
                      module.title,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A0A0A),
                      ),
                    ),
                  ],
                ),
                _buildCountBadge(module.count),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              module.description,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: Color(0xFF0A0A0A),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCountBadge(String count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1F7), // Light gray background for badge
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
    final Color buttonColor = Color(0xFFFFFFFF);

    final Color textColor = Color(0xFF0A0A0A);

    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onActionPressed,
        style: TextButton.styleFrom(
          backgroundColor: buttonColor,

          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          module.actionText,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
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
    return Card(
      color: Color(0xFFFFFFFF),
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
            Text(
              item.title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 10,
                color: Color(0xFF0A0A0A),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEDF1F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                item.count,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222B45),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
