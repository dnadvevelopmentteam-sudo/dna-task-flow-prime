import 'package:flutter/material.dart';

// NOTE: The responsive_extension import was removed as the extension definition is unavailable.
// The font size has been fixed to 16.0 instead of using context.scaleFont(16).

class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const DashboardSection({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color(0xFFEEEEEE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF0A0A0A),
                    fontFamily: 'Inter',
                    fontSize: 16.0, // Replaced context.scaleFont(16)
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}
