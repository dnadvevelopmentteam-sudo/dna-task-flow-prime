import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

Widget _buildCardTitle({required String title, required String subtitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0A0A0A),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF4A5565),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

Widget _buildTextInput({
  required String label,
  required String initialValue,
  bool isPassword = false,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF0A0A0A),
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        initialValue: initialValue,
        obscureText: isPassword,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.blue.shade400, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          suffixIcon: isPassword
              ? const Icon(Icons.remove_red_eye_outlined, color: Colors.black38)
              : null,
        ),
      ),
    ],
  );
}

class SystemScreen extends StatelessWidget {
  const SystemScreen({super.key});

  Widget _buildSystemToggle({
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
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Color(0xFF4A5565),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      isEnabled = newValue;
                    });
                  },
                  activeColor: Colors.black38,
                  activeTrackColor: Colors.black38,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade300,

                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
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
                  title: 'System Configuration',
                  subtitle: 'Manage global system settings and preferences',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextInput(
                        label: 'Site Name',
                        initialValue: 'Demo User',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTextInput(
                        label: 'Session Timeout (minutes)',
                        initialValue: '60',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildTextInput(
                  label: 'Site Name',
                  initialValue: 'Professional Task Management System',
                  maxLines: 5,
                ),
                const SizedBox(height: 32),

                _buildSystemToggle(
                  title: 'Task Assignments',
                  subtitle: 'Get notified when tasks are assigned to you',
                  initialValue: true,
                ),
                _buildSystemToggle(
                  title: 'Task Assignments',
                  subtitle: 'Get notified when tasks are assigned to you',
                  initialValue: true,
                ),
                const SizedBox(height: 8),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20),
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
