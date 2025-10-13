import 'package:dna_taskflow_prime/features/team/data/models/analytics_models.dart';
import 'package:dna_taskflow_prime/features/team/presentation/widgets/analytics_content.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsView extends StatelessWidget {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DashboardCard(
                title: 'Team Hours vs Target (Daily)',
                showIcon: true,
                child: SizedBox(height: 200, child: _buildDailyHoursChart()),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DashboardCard(
                title: 'Screenshot Coverage Distribution',
                child: SizedBox(
                  height: 200,
                  child: _buildCoverageDistributionChart(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  DashboardCard(
                    title: 'Est vs Actual Variance by Service',
                    child: _buildVarianceList(),
                  ),
                  const SizedBox(height: 20),
                  DashboardCard(
                    title: 'Utilization Mix by Service',
                    child: _buildUtilizationMix(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: DashboardCard(
                title: 'Approval SLA Funnel',
                child: _buildApprovalFunnel(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDailyHoursChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 12,
        interval: 3,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      series: <CartesianSeries>[
        ColumnSeries<DailyHoursData, String>(
          dataSource: dailyHoursData,
          xValueMapper: (DailyHoursData data, _) => data.day,
          yValueMapper: (DailyHoursData data, _) => data.target,
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        ColumnSeries<DailyHoursData, String>(
          dataSource: dailyHoursData,
          xValueMapper: (DailyHoursData data, _) => data.day,
          yValueMapper: (DailyHoursData data, _) => data.actual,
          color: Colors.blue.shade700,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }

  Widget _buildCoverageDistributionChart() {
    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<CoverageData, String>(
          dataSource: coverageData,
          pointColorMapper: (CoverageData data, _) => data.color,
          xValueMapper: (CoverageData data, _) => data.range,
          yValueMapper: (CoverageData data, _) => data.count,
          dataLabelMapper: (CoverageData data, _) =>
              '${data.range}: ${data.count}',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings: ConnectorLineSettings(
              type: ConnectorType.curve,
            ),
          ),
          // innerRadius: 70,
          explode: true,
          explodeIndex: 0,
        ),
      ],
      legend: const Legend(isVisible: false),
    );
  }

  Widget _buildVarianceList() {
    return Column(
      children: varianceData.map((data) => _buildVarianceItem(data)).toList(),
    );
  }

  Widget _buildVarianceItem(VarianceData data) {
    final bool isPositive = data.variance > 0;
    final color = isPositive ? Colors.red : Colors.blue;
    final sign = isPositive ? '+' : '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.service,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  data.client,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              'Est: ${data.estimatedHours}h | Actual: ${data.actualHours}h',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$sign${data.variance}h',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUtilizationMix() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: utilizationData
            .map((data) => _buildUtilizationCircle(data))
            .toList(),
      ),
    );
  }

  Widget _buildUtilizationCircle(UtilizationData data) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.color.withOpacity(0.2),
            ),
            alignment: Alignment.center,
            child: Text(
              '${data.percentage.toInt()}%',
              style: TextStyle(
                color: data.color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            data.service,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalFunnel() {
    final maxEntries = funnelData.first.entries;
    return Column(
      children: funnelData
          .map((data) => _buildFunnelItem(data, maxEntries))
          .toList(),
    );
  }

  Widget _buildFunnelItem(FunnelData data, int maxEntries) {
    final double widthFactor = data.entries / maxEntries;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.stage,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${data.entries} entries (${(data.percentage * 100).toStringAsFixed(0)}%)',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(height: 5),

          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              height: 8,
              width: double.infinity,
              color: Colors.grey.shade200,
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: widthFactor,
                child: Container(color: Colors.blue.shade600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
