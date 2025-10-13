import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String valueLine1;
  final String valueLine2;
  final IconData icon;
  final Color iconColor;
  final bool iconIsTrailing;

  const MetricCard({
    super.key,
    required this.title,
    required this.valueLine1,
    required this.valueLine2,
    required this.icon,
    required this.iconColor,
    this.iconIsTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Color(0xFF757575)),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              if (!iconIsTrailing) Icon(icon, size: 24, color: iconColor),
              if (!iconIsTrailing) const SizedBox(width: 8),
              Text(
                valueLine1,
                style: TextStyle(
                  fontSize: iconIsTrailing ? 24 : 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF333333),
                ),
              ),
              if (iconIsTrailing) const SizedBox(width: 8),
              if (iconIsTrailing) Icon(icon, size: 24, color: iconColor),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            valueLine2,
            style: const TextStyle(fontSize: 12, color: Color(0xFF9E9E9E)),
          ),
        ],
      ),
    );
  }
}
