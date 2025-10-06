import 'dart:ui';

import 'package:flutter/material.dart';

class TaskBoardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final bool isOutline;
  final double fontSize;

  const TaskBoardButton({
    required this.title,
    required this.icon,
    required this.fontSize,
    this.isPrimary = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isPrimary ? Colors.blue.shade700 : Colors.white;
    Color textColor = isPrimary ? Colors.white : Colors.grey.shade700;

    // Corrected type to BoxBorder?
    BoxBorder? border;

    if (isPrimary) {
      // Primary button: No border
      border = null;
    } else if (isOutline) {
      // Outline button: White background, grey text, requires Border.all()
      border = Border.all(color: Colors.grey.shade300, width: 1);
    }

    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(8),
        border: border, // Now accepts BoxBorder? or null
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: fontSize * 1.2),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}