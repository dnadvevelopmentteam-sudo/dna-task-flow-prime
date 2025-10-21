import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:flutter/material.dart';

class ClientsHeader extends StatelessWidget {
  const ClientsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clients',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: context.scaleFont(24),
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A0A0A),
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Manage your client relationships and contracts.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: context.scaleFont(14),
                color: Color(0xFF4A5565),
              ),
            ),
          ],
        ),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () {},
              icon: const ImageIcon(AssetImage('assets/icons/download.png')),
              label: Text(
                'Export',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: context.scaleFont(14),
                  color: Color(0xFF0A0A0A),
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF34495E),
                side: const BorderSide(color: Color(0xFFBDC3C7)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(width: 10),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: Text(
                'Add Client',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: context.scaleFont(14),
                  color: Color(0xFFFFFFFF),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
