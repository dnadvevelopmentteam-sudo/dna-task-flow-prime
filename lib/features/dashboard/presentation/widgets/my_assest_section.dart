import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
import 'package:dna_taskflow_prime/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:flutter/material.dart';

class MyAssetsSection extends StatelessWidget {
  const MyAssetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardSection(
      title: 'My Assets',
      trailing: Text(
        '0 assigned',
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: context.scaleFont(14),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.monitor,
              size: context.scaleFont(60),
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            Text(
              'No assets assigned to you yet',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: context.scaleFont(14),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
