import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MetricData {
  final String title;
  final String value;
  final String subtitle;
  final Color valueColor;
  final IconData icon;
  final Color iconColor;

  MetricData({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.valueColor,
    required this.icon,
    this.iconColor = const Color(0xFFB0B0B0),
  });
}

class ChartData {
  final String x;
  final double y;
  final Color color;

  ChartData(this.x, this.y, this.color);
}

class _HeaderTitleSection extends StatefulWidget {
  const _HeaderTitleSection();

  @override
  State<_HeaderTitleSection> createState() => _HeaderTitleSectionState();
}

class _HeaderTitleSectionState extends State<_HeaderTitleSection> {
  bool _isHovering = false;

  static const Color _baseChipColor = Color(0xFF3B82F6);

  Widget _buildFullAccessChip() {
    final Color chipColor = _isHovering ? _baseChipColor : _baseChipColor;

    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: const Text(
          'Full Access',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.arrow_back, color: Color(0xFF4A5565), size: 24),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Organization Analytics',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0A0A0A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Comprehensive timesheet insights and performance metrics',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF4A5565),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          _buildFullAccessChip(),
        ],
      ),
    );
  }
}

// --- MAIN DASHBOARD WIDGET ---

class OrganizationAnalyticsDashboard extends StatelessWidget {
  OrganizationAnalyticsDashboard({super.key});

  final List<MetricData> topMetrics = [
    MetricData(
      title: 'Total Hours',
      value: '1247.5h',
      subtitle: '+12.5% from last period',
      icon: Icons.access_time_outlined,
      valueColor: Color(0xFF3B82F6),
    ),
    MetricData(
      title: 'Avg Hours/Day',
      value: '7.8h',
      subtitle: 'Target 8.0h (78% meeting target)',
      icon: Icons.radio_button_checked,
      valueColor: Color(0xFF2C3E50),
    ),
    MetricData(
      title: 'Overtime Hours',
      value: '52.3h',
      subtitle: '4.2% of total hours',
      icon: Icons.trending_up,
      valueColor: Color(0xFFEF9E47),
    ),
    MetricData(
      title: 'Coverage Rate',
      value: '85%',
      subtitle: 'Screenshot coverage avg',
      icon: Icons.camera_alt_outlined,
      valueColor: Color(0xFF2C3E50),
    ),
  ];

  final List<MetricData> bottomMetrics = [
    MetricData(
      title: 'Comment Compliance',
      value: '92%',
      subtitle: 'Entries with valid remarks',
      icon: Icons.check_circle_outline,
      valueColor: Color(0xFF4BB543),
      iconColor: Color(0xFF4BB543),
    ),
    MetricData(
      title: 'Avg Approval Time',
      value: '18.5h',
      subtitle: 'From submission to approval',
      icon: Icons.insights_outlined,
      valueColor: Color(0xFF2C3E50),
    ),
    MetricData(
      title: 'Rejection Rate',
      value: '4.2%',
      subtitle: 'Entries requiring changes',
      icon: Icons.error_outline,
      valueColor: Color(0xFFE74C3C),
      iconColor: Color(0xFFE74C3C),
    ),
    MetricData(
      title: 'Shortfall Hours',
      value: '28.7h',
      subtitle: 'Below 8h daily target',
      icon: Icons.trending_down,
      valueColor: Color(0xFFE74C3C),
      iconColor: Color(0xFFE74C3C),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(context),

            _buildFilterBar(context),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              color: Color(0xFFFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetricCards(context, topMetrics),
                  const SizedBox(height: 20),

                  _buildMetricCards(context, bottomMetrics),
                  const SizedBox(height: 30),

                  _buildChartAndUtilizationSection(context),
                  const SizedBox(height: 30),

                  const ApprovalSLASecion(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),

      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: _HeaderTitleSection(),
            ),
          ),

          const SizedBox(width: 32),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.upload_outlined,
              size: 18,
              color: Color(0xFF6B7280),
            ),
            label: const Text(
              'Export',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            style: TextButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE5E7EB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),

          const SizedBox(width: 12),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.description_outlined,
              size: 18,
              color: Color(0xFF6B7280),
            ),
            label: const Text(
              'PDF Report',
              style: TextStyle(color: Color(0xFF6B7280)),
            ),
            style: TextButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE5E7EB)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search tasks, clients, remarks...',
                      hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Color(0xFFB0B0B0)),
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Dropdowns
              _buildDropdownFilter('Today', Icons.calendar_today_outlined),
              const SizedBox(width: 12),
              _buildDropdownFilter('All Clients', Icons.people_outline),
              const SizedBox(width: 12),
              _buildDropdownFilter('All Tasks', Icons.checklist_outlined),
              const SizedBox(width: 12),
              _buildDropdownFilter('All Status', Icons.menu_outlined),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz_outlined,
                    color: Color(0xFF8C98A6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              const Text(
                'Quick filters:',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF4A5565),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(width: 10),
              _buildQuickFilter('Drafts'),
              _buildQuickFilter('Pending Approval'),
              _buildQuickFilter('Overtime'),
              _buildQuickFilter('Low Coverage'),
              _buildQuickFilter(
                'More Filters',
                icon: Icons.filter_list_outlined,
              ),
              // const Spacer(),

              // _buildQuickFilter('Save View', icon: Icons.bookmark_border),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildQuickFilter('Save View', icon: Icons.bookmark_border),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildViewAction(String text, IconData icon) {
  //   return TextButton.icon(
  //     onPressed: () {},
  //     icon: Icon(icon, size: 18, color: Colors.blue.shade700),
  //     label: Text(
  //       text,
  //       style: TextStyle(
  //         color: Colors.blue.shade700,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDropdownFilter(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF8C98A6)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Color(0xFF8C98A6),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilter(
    String text, {
    IconData? icon,
    bool isSelected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.blue.shade700 : const Color(0xFFD9D9D9),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: Color(0xFF0A0A0A)),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              color: isSelected
                  ? Colors.blue.shade700
                  : const Color(0xFF0A0A0A),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCards(BuildContext context, List<MetricData> metrics) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = (constraints.maxWidth / 4) - 15;
        if (constraints.maxWidth < 800) {
          cardWidth = constraints.maxWidth;
        } else if (constraints.maxWidth < 1200) {
          cardWidth = (constraints.maxWidth / 2) - 15;
        }

        return Wrap(
          spacing: 4,
          // runSpacing: 20,
          children: metrics
              .map(
                (m) => MetricCard(
                  width: cardWidth,
                  title: m.title,
                  value: m.value,
                  subtitle: m.subtitle,
                  valueColor: m.valueColor,
                  icon: m.icon,
                  iconColor: m.iconColor,
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildChartAndUtilizationSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ChartCard(
                title: 'Hours vs Target (By Day)',
                height: 300,
                icon: Icons.bar_chart_outlined,
                child: HoursVsTargetChartVisual(),
              ),
              const SizedBox(height: 20),
              ChartCard(
                title: 'Coverage Distribution',
                height: 300,
                icon: Icons.access_time_outlined,
                child: CoverageDistributionChartVisual(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ChartCard(
                title: 'Est vs Actual Variance',
                height: 300,
                icon: Icons.insights_outlined,
                // trailing: Row(
                //   children: [
                //     TextButton(
                //       onPressed: () {},
                //       child: const Text(
                //         'Charts',
                //         style: TextStyle(color: Color(0xFF8C98A6)),
                //       ),
                //     ),
                //     Container(
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 10,
                //         vertical: 6,
                //       ),
                //       decoration: BoxDecoration(
                //         color: Colors.blue.shade700,
                //         borderRadius: BorderRadius.circular(6),
                //       ),
                //       child: const Text(
                //         'Table',
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     ),
                //   ],
                // ),
                child: EstVsActualVarianceChartVisual(),
              ),
              const SizedBox(height: 20),
              ChartCard(
                title: 'Client Utilization',
                height: 300,
                icon: Icons.people_outline,
                child: const ClientUtilizationList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

// --- REUSABLE COMPONENTS ---

/// Widget for the Key Metric Cards (Top and Bottom Rows).
class MetricCard extends StatelessWidget {
  final double width;
  final String title;
  final String value;
  final String subtitle;
  final Color valueColor;
  final IconData icon;
  final Color iconColor;

  const MetricCard({
    super.key,
    required this.width,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.valueColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(8),
        ),
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0A),
                        ),
                      ),
                      const Spacer(),
                      Icon(icon, size: 16, color: iconColor),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: valueColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0A0A0A),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A generic wrapper for chart widgets.
class ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  final double height;
  final Widget? trailing;
  final IconData icon;

  const ChartCard({
    super.key,
    required this.title,
    required this.child,
    required this.height,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFFFFF),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(20),
        height: height,
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: const Color(0xFF2C3E50)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0A0A0A),
                  ),
                ),
                const Spacer(),
                if (trailing != null)
                  trailing!
                else
                  const Icon(Icons.circle, size: 20, color: Color(0xFFD9D9D9)),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

// --- CHART VISUALIZATIONS (Using Syncfusion Charts) ---

// 1. Hours vs Target (By Day) - Grouped Bar Chart
class HoursVsTargetChartVisual extends StatelessWidget {
  HoursVsTargetChartVisual({super.key});

  final List<ChartData> series1 = [
    ChartData('Mon', 7.5, Color(0xFF3B82F6)),
    ChartData('Tue', 8.0, Color(0xFF3B82F6)),
    ChartData('Wed', 7.8, Color(0xFF3B82F6)),
    ChartData('Thu', 8.2, Color(0xFF3B82F6)),
    ChartData('Fri', 7.0, Color(0xFF3B82F6)),
  ];
  final List<ChartData> series2 = [
    ChartData('Mon', 8.0, Color(0xFFEF9E47)),
    ChartData('Tue', 7.5, Color(0xFFEF9E47)),
    ChartData('Wed', 8.2, Color(0xFFEF9E47)),
    ChartData('Thu', 7.5, Color(0xFFEF9E47)),
    ChartData('Fri', 7.5, Color(0xFFEF9E47)),
  ];
  final List<ChartData> series3 = [
    ChartData('Mon', 6.8, Color(0xFF8B5CF6)),
    ChartData('Tue', 8.5, Color(0xFF8B5CF6)),
    ChartData('Wed', 7.2, Color(0xFF8B5CF6)),
    ChartData('Thu', 8.0, Color(0xFF8B5CF6)),
    ChartData('Fri', 6.5, Color(0xFF8B5CF6)),
  ];
  final List<ChartData> series4 = [
    ChartData('Mon', 8.5, Color(0xFF10B981)),
    ChartData('Tue', 7.8, Color(0xFF10B981)),
    ChartData('Wed', 8.8, Color(0xFF10B981)),
    ChartData('Thu', 7.0, Color(0xFF10B981)),
    ChartData('Fri', 8.2, Color(0xFF10B981)),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF8C98A6)),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 12,
        interval: 3,
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(
          color: Color(0xFFE0E0E0),
          width: 0.5,
        ),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF8C98A6)),
      ),
      series: <CartesianSeries>[
        ColumnSeries<ChartData, String>(
          dataSource: series1,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: series1[0].color,
          borderRadius: BorderRadius.circular(4),
          spacing: 0.1,
        ),
        ColumnSeries<ChartData, String>(
          dataSource: series2,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: series2[0].color,
          borderRadius: BorderRadius.circular(4),
          spacing: 0.1,
        ),
        ColumnSeries<ChartData, String>(
          dataSource: series3,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: series3[0].color,
          borderRadius: BorderRadius.circular(4),
          spacing: 0.1,
        ),
        ColumnSeries<ChartData, String>(
          dataSource: series4,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: series4[0].color,
          borderRadius: BorderRadius.circular(4),
          spacing: 0.1,
        ),
      ],
    );
  }
}

// 2. Est vs Actual Variance - Horizontal Bar Chart
class EstVsActualVarianceChartVisual extends StatelessWidget {
  EstVsActualVarianceChartVisual({super.key});

  final List<ChartData> chartData = [
    ChartData('Audit Support', 0.8, Color(0xFFD6DCE5)),
    ChartData('IT Filing', 0.4, Color(0xFFD6DCE5)),
    ChartData('TDS Compliance', 0.9, Color(0xFF3B82F6)),
    ChartData('GST Filing', 0.7, Color(0xFF3B82F6)),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        minimum: 0,
        maximum: 1,
        interval: 0.25,
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(
          color: Color(0xFFE0E0E0),
          width: 0.5,
        ),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF8C98A6)),
      ),
      primaryYAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF2C3E50)),
      ),
      series: <BarSeries>[
        BarSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}

// 3. Coverage Distribution - Donut Chart

class CoverageDistributionChartVisual extends StatelessWidget {
  CoverageDistributionChartVisual({super.key});

  final List<ChartData> chartData = [
    ChartData('80-100%', 60, Color(0xFF10B981)),
    ChartData('50-80%', 20, Color(0xFFEF9E47)),
    ChartData('0-50%', 10, Color(0xFFE74C3C)),
    ChartData('Other', 10, Color(0xFFD6DCE5)),
  ];

  final List<Map<String, dynamic>> customLegendItems = const [
    {'label': '0-50%', 'count': 12, 'color': Color(0xFFE74C3C)},
    {'label': '50-80%', 'count': 28, 'color': Color(0xFFEF9E47)},
    {'label': '80-100%', 'count': 145, 'color': Color(0xFF10B981)},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfCircularChart(
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                widget: Text(
                  '85%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                pointColorMapper: (ChartData data, _) => data.color,
                innerRadius: '70%',
                radius: '90%',
                cornerStyle: CornerStyle.bothCurve,
                explode: false,
              ),
            ],
            margin: EdgeInsets.zero,
            legend: const Legend(isVisible: false),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: customLegendItems.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: item['color'] as Color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${item['label']} (${item['count']})',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF5A677B),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// 4. Client Utilization - List with Progress Bars
class ClientUtilizationList extends StatelessWidget {
  const ClientUtilizationList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> clients = [
      {
        'name': 'Acme Corp',
        'hours': '245h',
        'percent': 85,
        'color': const Color(0xFF3B82F6),
      }, // Blue
      {
        'name': 'Manufacturing Co',
        'hours': '198h',
        'percent': 72,
        'color': const Color(0xFF8B5CF6),
      }, // Purple
      {
        'name': 'Tech Startup',
        'hours': '156h',
        'percent': 68,
        'color': const Color(0xFF10B981),
      }, // Green
      {
        'name': 'Retail Chain',
        'hours': '134h',
        'percent': 62,
        'color': const Color(0xFFEF9E47),
      }, // Orange
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client['name'],
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Stack(
                        children: [
                          Container(
                            height: 8,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: client['percent'] / 100,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(
                                color: client['color'] as Color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    client['hours'],
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: (client['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${client['percent']}%',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: client['color'] as Color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// 5. Approval SLA Funnel - Area Chart (Full Width Section)
class ApprovalSLASecion extends StatelessWidget {
  const ApprovalSLASecion({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: 'Approval SLA Funnel',
      height: 300,
      icon: Icons.show_chart,
      child: ApprovalSLACalculator(),
    );
  }
}

class ApprovalSLACalculator extends StatelessWidget {
  ApprovalSLACalculator({super.key});

  final List<ChartData> chartData = [
    ChartData('Submitted', 180, Color(0xFF3B82F6)),
    ChartData('TM Review', 165, Color(0xFF3B82F6)),
    ChartData('GM Review', 130, Color(0xFF3B82F6)),
    ChartData('EP Review', 110, Color(0xFF3B82F6)),
    ChartData('Approved', 105, Color(0xFF3B82F6)),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(width: 0),
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF2C3E50)),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 180,
        interval: 45,
        axisLine: const AxisLine(width: 0),
        majorGridLines: const MajorGridLines(
          color: Color(0xFFE0E0E0),
          width: 0.5,
        ),
        majorTickLines: const MajorTickLines(size: 0),
        labelStyle: const TextStyle(fontSize: 12, color: Color(0xFF8C98A6)),
      ),
      series: <AreaSeries>[
        AreaSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: const Color(0xFF3B82F6).withOpacity(0.2), // Light blue fill
          borderColor: const Color(0xFF3B82F6), // Darker blue border
          borderWidth: 2,
          borderDrawMode: BorderDrawMode.top, // Only draw top border line
        ),
      ],
    );
  }
}
