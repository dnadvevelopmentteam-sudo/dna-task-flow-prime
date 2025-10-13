import 'package:dna_taskflow_prime/features/notices/data/models/notice_models.dart';
import 'package:dna_taskflow_prime/features/notices/presentation/pages/notices_page.dart';
import 'package:flutter/material.dart';

class PriorityButton extends StatefulWidget {
  final Priority priority;
  const PriorityButton({super.key, required this.priority});

  @override
  State<PriorityButton> createState() => _PriorityButtonState();
}

class _PriorityButtonState extends State<PriorityButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColorss.getPriorityColor(widget.priority);
    final isCritical = widget.priority == Priority.critical;

    Color buttonColor = isCritical ? AppColorss.critical : baseColor;
    Color textColor = isCritical ? Colors.white : AppColorss.textDark;

    if (_isHovering) {
      buttonColor = buttonColor.withOpacity(0.8);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          widget.priority.name.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
