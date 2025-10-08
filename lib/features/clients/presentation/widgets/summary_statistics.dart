import 'package:flutter/material.dart';

class SummaryStatistics extends StatelessWidget {
  const SummaryStatistics({super.key});

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
    required String assetIconPath,
  }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: color.withOpacity(0.1),
                    child: Image.asset(
                      assetIconPath,
                      color: color,
                      width: 16,
                      height: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
    return Row(
      children: [
        _buildStatCard(
          value: '24',
          label: 'Total Clients',
          color: const Color(0xFF0A0A0A),
          assetIconPath: 'assets/icons/files_icon.png',
        ),
        const SizedBox(width: 15),
        _buildStatCard(
          value: '42.5',
          label: 'Active',
          color: const Color(0xFF2980B9),
          assetIconPath: 'assets/icons/active_icon.png',
        ),
        const SizedBox(width: 15),
        _buildStatCard(
          value: '3',
          label: 'Renewal Due',
          color: const Color(0xFF2ECC71),
          assetIconPath: 'assets/icons/clock_icon.png',
        ),
        const SizedBox(width: 15),
        _buildStatCard(
          value: '156',
          label: 'Inactive',
          color: const Color(0xFF95A5A6),
          assetIconPath: 'assets/icons/inactive_icon.png',
        ),
      ],
    );
  }
}
