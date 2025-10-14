import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:dna_taskflow_prime/features/settings/presentation/widgets/notification_screen.dart';
import 'package:dna_taskflow_prime/features/settings/presentation/widgets/profile_screen.dart';
import 'package:dna_taskflow_prime/features/settings/presentation/widgets/security_screen.dart';
import 'package:dna_taskflow_prime/features/settings/presentation/widgets/system_screen.dart';
import 'package:flutter/material.dart';

enum SettingsTab { profile, notification, security, system }

class SettingsContentArea extends StatefulWidget {
  const SettingsContentArea({super.key});

  @override
  State<SettingsContentArea> createState() => _SettingsContentAreaState();
}

class _SettingsContentAreaState extends State<SettingsContentArea> {
  SettingsTab _selectedTab = SettingsTab.profile;

  String _getTabName(SettingsTab tab) {
    switch (tab) {
      case SettingsTab.profile:
        return 'Profile';
      case SettingsTab.notification:
        return 'Notification';
      case SettingsTab.security:
        return 'Security';
      case SettingsTab.system:
        return 'System';
    }
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: SettingsTab.values.map((tab) {
          final isSelected = _selectedTab == tab;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                _getTabName(tab),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: context.scaleFont(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedTab = tab;
                  });
                }
              },
              showCheckmark: false,

              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              // backgroundColor: isSelected
              //     ? AppColors.primaryDark
              //     : const Color(0xFFFFFFFF),
              backgroundColor: const Color(0xFFFFFFFF),
              selectedColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Color(0xFFFFFFFF)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper method to switch the content based on the selected ta
  Widget _buildContent() {
    switch (_selectedTab) {
      case SettingsTab.profile:
        return const ProfileScreen();
      case SettingsTab.notification:
        return const NotificationScreen();
      case SettingsTab.security:
        return const SecurityScreen();
      case SettingsTab.system:
        return const SystemScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Padding matches the visual spacing in the image
      padding: const EdgeInsets.all(24.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Tab Bar
          _buildTabBar(),
          const SizedBox(height: 24.0),
          // 2. Tab Content (Expanded to fill the rest of the available vertical space)
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }
}
