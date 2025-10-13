import 'package:dna_taskflow_prime/features/notices/presentation/pages/notices_page.dart';
import 'package:flutter/material.dart';

class MarkAsReadButton extends StatefulWidget {
  final VoidCallback onPressed;
  const MarkAsReadButton({super.key, required this.onPressed});

  @override
  State<MarkAsReadButton> createState() => _MarkAsReadButtonState();
}

class _MarkAsReadButtonState extends State<MarkAsReadButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color baseBorderColor = AppColorss.textLight.withOpacity(0.5);
    const Color baseTextColor = AppColorss.textDark;
    const Color baseIconColor = AppColorss.textDark;

    const Color hoverBgColor = AppColorss.primary;
    const Color hoverTextColor = Colors.white;
    const Color hoverIconColor = Colors.white;

    final Color effectiveBgColor = _isHovering
        ? hoverBgColor
        : Colors.transparent;
    final Color effectiveTextColor = _isHovering
        ? hoverTextColor
        : baseTextColor;
    final Color effectiveIconColor = _isHovering
        ? hoverIconColor
        : baseIconColor;
    final Color effectiveBorderColor = _isHovering
        ? AppColorss.primary
        : baseBorderColor;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: OutlinedButton.icon(
        onPressed: widget.onPressed,
        icon: Icon(
          Icons.check_circle_outline,
          size: 16,
          color: effectiveIconColor,
        ),
        label: Text(
          'Mark as Read',
          style: TextStyle(
            fontSize: 13,
            color: effectiveTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          side: BorderSide(color: effectiveBorderColor),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
      ),
    );
  }
}
