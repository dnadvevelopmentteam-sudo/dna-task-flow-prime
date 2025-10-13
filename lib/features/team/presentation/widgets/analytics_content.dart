import 'package:dna_taskflow_prime/features/team/presentation/widgets/charts_view.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/table_view.dart';
import 'package:flutter/material.dart';

class AnalyticsContent extends StatefulWidget {
  const AnalyticsContent({super.key});

  @override
  State<AnalyticsContent> createState() => _AnalyticsContentState();
}

class _AnalyticsContentState extends State<AnalyticsContent> {
  bool _isChartView = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth / 2) - 80;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ToggleButtons(
                isSelected: [_isChartView, !_isChartView],
                onPressed: (index) {
                  setState(() {
                    _isChartView = index == 0;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                fillColor: Colors.blue.shade50,
                selectedColor: Colors.blue.shade700,
                color: Colors.grey.shade600,
                borderColor: Colors.transparent,
                selectedBorderColor: Colors.transparent,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Charts',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Table View',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        if (_isChartView) const ChartsView() else const TableView(),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showIcon;

  const DashboardCard({
    required this.title,
    required this.child,
    this.showIcon = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showIcon)
                Icon(
                  Icons.visibility_outlined,
                  size: 20,
                  color: Colors.grey.shade500,
                ),
            ],
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}
