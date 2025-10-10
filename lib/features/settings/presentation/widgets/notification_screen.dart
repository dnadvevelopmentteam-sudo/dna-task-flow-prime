import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Widget _buildCardTitle({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            // fontSize: context.scaleFont(20),
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A0A0A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
            // fontSize: context.scaleFont(14),
            fontSize: 14,
            color: Color(0xFF4A5565),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNotificationToggle({
    required String title,
    required String subtitle,
    required bool initialValue,
  }) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        bool isEnabled = initialValue;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                // The Switch widget is used for functionality and styled to match the image's colors
                Switch(
                  value: isEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      isEnabled = newValue;
                    });
                    // In a real app, you would call an API to save the setting here
                  },
                  activeColor: Colors.blue.shade700, // Blue when enabled
                  inactiveThumbColor: Colors.grey, // Gray when disabled
                  inactiveTrackColor: Colors.grey.shade300, // Light gray track
                  // Adjust size slightly to fit the layout better
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
            // Add a small divider/space for separation, similar to the image
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          color: Color(0xFFFFFFFF),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCardTitle(
                  title: 'Profile Information',
                  subtitle:
                      'Update your personal information and account details',
                ),
                _buildNotificationToggle(
                  title: 'Full Name',
                  subtitle: 'Receive notifications via email',
                  initialValue: true,
                ),
                _buildNotificationToggle(
                  title: 'Task Assignments',
                  subtitle: 'Get notified when tasks are assigned to you',
                  initialValue: true,
                ),
                _buildNotificationToggle(
                  title: 'Due Date Reminders',
                  subtitle: 'Receive reminders for upcoming due dates',
                  initialValue: true,
                ),
                _buildNotificationToggle(
                  title: 'Team Updates',
                  subtitle: 'Stay informed about team activities',
                  initialValue: true,
                ),

                const SizedBox(height: 8),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    'Save Profile',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: context.scaleFont(14),
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.primaryDark,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
