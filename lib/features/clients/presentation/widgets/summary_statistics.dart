import 'package:flutter/material.dart';

class SummaryStatistics extends StatelessWidget {
  const SummaryStatistics({super.key});

  Widget _buildDotIndicator({required Color color}) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color valueColor,
    required Widget indicatorWidget,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color(0xFFEEEEEE), width: 1.0),
        ),

        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: valueColor,
                    ),
                  ),
                  indicatorWidget,
                ],
              ),
              const SizedBox(height: 12),

              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF6A7282),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color totalClientsColor = Color(0xFF1976D2);
    const Color activeColor = Color(0xFF4CAF50);
    const Color renewalColor = Color(0xFFFF9800);
    const Color inactiveColor = Color(0xFF546E7A);

    return Row(
      children: [
        _buildStatCard(
          value: '47',
          label: 'Total Clients',
          valueColor: totalClientsColor,
          indicatorWidget: Image.asset(
            'assets/icons/files_icon.png',
            // color: totalClientsColor,
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 15),

        _buildStatCard(
          value: '42',
          label: 'Active',
          valueColor: activeColor,
          indicatorWidget: _buildDotIndicator(color: activeColor),
        ),
        const SizedBox(width: 15),

        _buildStatCard(
          value: '3',
          label: 'Renewal Due',
          valueColor: renewalColor,
          indicatorWidget: Image.asset(
            'assets/icons/clock_icon.png',
            color: renewalColor,
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 15),

        _buildStatCard(
          value: '2',
          label: 'Inactive',
          valueColor: inactiveColor,
          indicatorWidget: _buildDotIndicator(color: inactiveColor),
        ),
      ],
    );
  }
}
