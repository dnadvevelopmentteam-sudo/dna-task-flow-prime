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
          fontFamily: 'Inter',
          fontSize: 14,
          color: Color(0xFF4A5565),
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  Widget _buildSecuritySectionItem({
    required String title,
    required String subtitle,
    required Widget content,
  }) {
    return Column(
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
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFF4A5565),
          ),
        ),
        const SizedBox(height: 16),
        content,
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
                  title: 'Security Settings',
                  subtitle: 'Manage your account security and privacy settings',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildSecuritySectionItem(
                        title: 'Two-Factor Authentication',
                        subtitle:
                            'Add an extra layer of security to your account',
                        content: ElevatedButton.icon(
                          onPressed: () {
                            // Action: Enable 2FA
                          },
                          icon: const Icon(Icons.lock, size: 16),
                          label: const Text('Enable 2FA'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryDark,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 24),
                    Expanded(
                      child: _buildSecuritySectionItem(
                        title: 'Active Sessions',
                        subtitle: 'Manage your active login sessions',
                        content: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFEBF5EC),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '2 Active Sessions',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color(0xFF14A249),
                                  fontWeight: FontWeight.w400,
                                  fontSize: context.scaleFont(12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
