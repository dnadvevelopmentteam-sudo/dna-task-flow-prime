import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildCardTitle({required String title, required String subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            // fontSize: context.scaleFont(20),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0A0A0A),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w300,
            fontSize: 14,
            // fontSize: context.scaleFont(14),
            color: Color(0xFF4A5565),
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            // fontSize: context.scaleFont(14),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF0A0A0A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          obscureText: isPassword,
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
            // Mock suffix icon for password fields
            suffixIcon: isPassword
                ? const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.black38,
                  )
                : null,
          ),
        ),
      ],
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
                // Layout Full Name and Email side-by-side using Row/Expanded
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextInput(
                        label: 'Full Name',
                        initialValue: 'Demo User',
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTextInput(
                        label: 'Email Address',
                        initialValue: 'demo@exairr',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Save Profile Button
                ElevatedButton.icon(
                  onPressed: () {
                    // Action: Save Profile
                  },
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    'Save Profile',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: context.scaleFont(14),
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
        const SizedBox(height: 24),

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
                  title: 'Change Password',
                  subtitle: 'Update your password to keep your account secure',
                ),
                _buildTextInput(
                  label: 'Current Password',
                  initialValue: 'Demo User',
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTextInput(
                        label: 'New Password',
                        initialValue: 'Demo@exairr',
                        isPassword: true,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildTextInput(
                        label: 'Confirm Password',
                        initialValue: 'Demo@exairr',
                        isPassword: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Update Password Button
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    'Update Password',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: context.scaleFont(14),
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
