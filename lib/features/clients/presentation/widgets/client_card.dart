import 'package:flutter/material.dart';

import '../../data/models/client.dart';

class ClientCard extends StatelessWidget {
  Color? _resolveColor(
    Set<WidgetState> states,
    Color defaultColor,
    Color hoverColor,
  ) {
    if (states.contains(WidgetState.hovered)) {
      return hoverColor;
    }
    return defaultColor;
  }

  final Client client;
  final double width;

  const ClientCard({super.key, required this.client, required this.width});

  static const Color activeGreen = Color(0xFF4CAF50);
  static const Color inactiveSlate = Color(0xFF546E7A);
  // static const Color primaryBlue = Color(0xFF1976D2);
  static Color primaryBlue = Color(0xFF3498DB);
  static Color defaultTextColor = Color(0xFF34495E);
  static Color defaultBorderColor = Color(0xFFBDC3C7);
  static Color lightHoverBackground = Color(0xFFECF0F1);

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF95A5A6)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF34495E),
              fontFamily: 'Inter',
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildDualInfoRow({
    required IconData icon1,
    required String text1,
    required IconData icon2,
    required String text2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(child: _buildInfoItem(icon1, text1)),
          const SizedBox(width: 20),
          Expanded(child: _buildInfoItem(icon2, text2)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: const Color(0xFFEEEEEE), width: 1.0),
      ),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                        fontFamily: 'Inter',
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      client.type,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7F8C8D),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: client.isActive ? activeGreen : inactiveSlate,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  client.isActive ? 'Active' : 'Inactive',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          _buildDualInfoRow(
            icon1: Icons.email_outlined,
            text1: client.email,
            icon2: Icons.phone_outlined,
            text2: client.phone,
          ),
          _buildDualInfoRow(
            icon1: Icons.calendar_today_outlined,
            text1:
                'Contract ends: ${client.contractEnd.day}/${client.contractEnd.month}/${client.contractEnd.year}',
            icon2: Icons.task_alt_outlined,
            text2: '${client.activeTasks} active tasks',
          ),

          const SizedBox(height: 15),

          const Text(
            'Services:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0A0A0A),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 6.0,
            children: client.services
                .map(
                  (service) => Chip(
                    label: Text(
                      service,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF34495E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    backgroundColor: const Color(0xFFECF0F1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style:
                      OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ).copyWith(
                        // 1. Text Color Change on Hover
                        foregroundColor:
                            WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) => _resolveColor(
                                states,
                                defaultTextColor,
                                Colors.blue,
                              ),
                            ),
                        // backgroundColor:
                        //     WidgetStateProperty.resolveWith<Color?>(
                        //       (Set<WidgetState> states) => _resolveColor(
                        //         states,
                        //         Colors.white,
                        //         Color(0xFFD9D9D9),
                        //       ),
                        //     ),
                        side: WidgetStateProperty.resolveWith<BorderSide?>((
                          Set<WidgetState> states,
                        ) {
                          final color = _resolveColor(
                            states,
                            defaultBorderColor,
                            primaryBlue,
                          );
                          return BorderSide(color: color!, width: 1.5);
                        }),
                      ),
                  child: Text('View Details'),
                ),
              ),
              const SizedBox(width: 300),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: defaultTextColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: defaultBorderColor,
                            width: 1.5,
                          ),
                        ),
                      ).copyWith(
                        foregroundColor:
                            WidgetStateProperty.resolveWith<Color?>(
                              (Set<WidgetState> states) => _resolveColor(
                                states,
                                defaultTextColor,
                                Colors.blue,
                              ),
                            ),
                        // backgroundColor:
                        //     WidgetStateProperty.resolveWith<Color?>(
                        //       (Set<WidgetState> states) => _resolveColor(
                        //         states,
                        //         Colors.white,
                        //         primaryBlue,
                        //       ),
                        //     ),
                        side: WidgetStateProperty.resolveWith<BorderSide?>((
                          Set<WidgetState> states,
                        ) {
                          final color = _resolveColor(
                            states,
                            defaultBorderColor,
                            Colors.blue,
                          );
                          return BorderSide(color: color!, width: 1.5);
                        }),
                      ),
                  child: const Text('Manage Tasks'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
