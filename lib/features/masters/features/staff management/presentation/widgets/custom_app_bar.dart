import 'package:dna_taskflow_prime/features/masters/features/staff%20management/presentation/pages/staff_management_page.dart';
import 'package:flutter/material.dart';

import 'custom_back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String currentScreen;

  const CustomAppBar({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0, // Consistent with your requirement
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: kDividerColor, width: 1.0)),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back Button
          CustomBackButton(onPressed: () => Navigator.pop(context)),
          const SizedBox(width: 24),

          // Home Icon
          HomeIcon(onPressed: () {}),
          const SizedBox(width: 8),

          // Masters Link
          MastersBreadcrumbItem(
            onPressed: () {
              // Placeholder: Navigate back to the Masters hub (e.g., pop)
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),

          // Separator
          const Icon(
            Icons.chevron_right,
            size: 16,
            color: kDefaultBreadcrumbColor,
          ),
          const SizedBox(width: 8),

          // Current Screen (Non-interactive)
          Text(
            currentScreen,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF0A0A0A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
