import 'package:dna_taskflow_prime/core/theme/colors.dart';
import 'package:flutter/material.dart';

class ChartTableToggle extends StatefulWidget {
  const ChartTableToggle({super.key});

  @override
  State<ChartTableToggle> createState() => _ChartTableToggleState();
}

class _ChartTableToggleState extends State<ChartTableToggle> {
  int _selectedIndex = 0;

  Widget _toggleTab({
    required String text,
    required bool isSelected,
    required IconData? icon,
    required int index,
  }) {
    final backgroundColor = isSelected ? AppColors.primaryDark : Colors.white;
    final contentColor = isSelected ? Colors.white : const Color(0xFF5A5A5A);
    final borderColor = isSelected
        ? AppColors.primaryDark
        : const Color(0xFFD3D3D3);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor, width: isSelected ? 0 : 1),

          boxShadow: isSelected
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: contentColor),
              const SizedBox(width: 6),
            ],
            Text(
              text,
              style: TextStyle(
                color: contentColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _toggleTab(
          text: 'Charts',
          isSelected: _selectedIndex == 0,
          icon: null,
          index: 0,
        ),

        const SizedBox(width: 8),
        _toggleTab(
          text: 'Table View',

          isSelected: _selectedIndex == 1,
          icon: Icons.grid_view_sharp,
          index: 1,
        ),
      ],
    );
  }
}
