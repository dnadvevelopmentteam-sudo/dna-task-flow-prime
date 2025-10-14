import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.title,
    required this.icon,
    this.isPrimary = false,
    this.onTap,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool _isHovering = false;

  void _onHover(bool hover) {
    if (!widget.isPrimary) {
      setState(() {
        _isHovering = hover;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppColors.primary;
    const Color defaultBorderColor = Color(0xFFEEEEEE);
    final Color hoverBgColor = Colors.grey;
    final Color defaultIconColor = Colors.grey.shade700;
    const Color defaultTextColor = Colors.black;

    Color backgroundColor;
    Color iconColor;
    Color textColor;
    BorderSide borderSide;

    if (widget.isPrimary) {
      backgroundColor = primaryColor;
      iconColor = Colors.white;
      textColor = Colors.white;
      borderSide = BorderSide.none;
    } else if (_isHovering) {
      backgroundColor = hoverBgColor;
      iconColor = primaryColor;
      textColor = primaryColor;
      borderSide = BorderSide(color: primaryColor, width: 1);
    } else {
      backgroundColor = Colors.white;
      iconColor = defaultIconColor;
      textColor = defaultTextColor;
      borderSide = const BorderSide(color: defaultBorderColor, width: 1);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: borderSide.color,
              width: borderSide.width,
            ),
            boxShadow: [
              if (widget.isPrimary)
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(widget.icon, color: iconColor, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: widget.isPrimary || _isHovering
                            ? FontWeight.w600
                            : FontWeight.w500,
                        fontSize: context.scaleFont(14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
