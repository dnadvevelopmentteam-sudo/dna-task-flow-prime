import 'package:flutter/material.dart';

Widget buildUtilizationMix() {
  const Color developmentColor = Color(0xFF4285F4);
  const Color qaTestingColor = Color(0xFF0F9D58);
  const Color designColor = Color(0xFFF4B400);
  const Color documentationColor = Color(0xFFAA46BC);

  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFD9D9D9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Utilization Mix by Service',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A0A0A),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _utilizationDonut(
              'Development',
              45,
              developmentColor,
              Colors.white,
            ),
            _utilizationDonut('QA Testing', 25, qaTestingColor, Colors.white),
            _utilizationDonut('Design', 20, designColor, Colors.white),
            _utilizationDonut(
              'Documentation',
              10,
              documentationColor,
              Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

Widget _utilizationDonut(
  String service,
  int percentage,
  Color circleColor,
  Color percentageTextColor,
) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 80,
            height: 80, // Reduced size slightly for a better visual match
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: circleColor,
            ),
          ),
          Text(
            '$percentage%',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: percentageTextColor,
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Text(
        service,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color(0xFF0A0A0A),
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}
