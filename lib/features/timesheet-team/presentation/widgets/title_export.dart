import 'package:flutter/material.dart';

Widget buildTitleAndExport() {
  Widget customExportButton = Container(
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      // boxShadow: [
      //   BoxShadow(
      //     color: const Color(0xFFE2E8F0).withOpacity(0.5),
      //     spreadRadius: 0,
      //     blurRadius: 1,
      //     offset: const Offset(0, 1),
      //   ),
      // ],
    ),
    child: TextButton.icon(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        foregroundColor: const Color(0xFF1A202C),
      ),
      icon: const Icon(Icons.file_download_outlined, size: 16),
      label: const Text(
        'Export',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 16.0,
          color: Color(0xFF0A0A0A),
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Team Timesheets',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color(0xFF0A0A0A),
          fontWeight: FontWeight.w600,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Monitor team productivity and time tracking analytics',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Color(0xFF4A5565),
            ),
          ),
          customExportButton,
        ],
      ),
    ],
  );
}
