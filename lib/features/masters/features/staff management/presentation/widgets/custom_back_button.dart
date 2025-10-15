import 'package:dna_taskflow_prime/features/masters/features/staff%20management/presentation/pages/staff_management_page.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CustomBackButton({super.key, required this.onPressed});

  @override
  State<CustomBackButton> createState() => BackButtonState();
}

class BackButtonState extends State<CustomBackButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color color = _isHovering ? kHoverBlueColor : kDefaultBreadcrumbColor;

    return InkWell(
      onTap: widget.onPressed,
      onHover: (hover) {
        setState(() {
          _isHovering = hover;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back, color: color, size: 20),
            const SizedBox(width: 4),
            Text(
              'Back',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
