import 'package:flutter/material.dart';

const Color kPrimaryBlue = Color(0xFF1E88E5);
const Color kTargetGrey = Color(0xFFE0E0E0);
const Color kPieGreen = Color(0xFF4CAF50);
const Color kPieOrange = Color(0xFFFF9800);
const Color kPieRed = Color(0xFFF44336);

class ChartData {
  final String day;
  final double actual;
  final double target;

  ChartData(this.day, this.actual, this.target);
}

final List<ChartData> teamHoursData = [
  ChartData('Mon', 7.5, 8.0),
  ChartData('Tue', 8.2, 8.0),
  ChartData('Wed', 7.8, 8.0),
  ChartData('Thu', 8.5, 8.0),
  ChartData('Fri', 7.8, 8.0),
];

class PieData {
  final String category;
  final int count;
  final Color color;

  PieData(this.category, this.count, this.color);
}

final List<PieData> pieData = [
  PieData('80-100%', 15, kPieGreen),
  PieData('50-80%', 8, kPieOrange),
  PieData('0-50%', 2, kPieRed),
];

class VarianceData {
  final String service;
  final String client;
  final int est;
  final int actual;

  VarianceData({
    required this.service,
    required this.client,
    required this.est,
    required this.actual,
  });
}

final List<VarianceData> varianceList = [
  VarianceData(
    service: 'Development',
    client: 'Client A',
    est: 120,
    actual: 135,
  ),
  VarianceData(service: 'QA Testing', client: 'Client B', est: 80, actual: 75),
  VarianceData(service: 'Design', client: 'Client C', est: 60, actual: 68),
];

class FunnelData {
  final String status;
  final int entries;
  final double percentage;

  FunnelData({
    required this.status,
    required this.entries,
    required this.percentage,
  });
}

final List<FunnelData> funnelList = [
  FunnelData(status: 'Submitted', entries: 45, percentage: 1.00),
  FunnelData(status: 'TM Review', entries: 38, percentage: 0.84),
  FunnelData(status: 'GM Review', entries: 32, percentage: 0.71),
  FunnelData(status: 'EP Approved', entries: 30, percentage: 0.67),
];

Widget _buildSyncfusionBarChart() {
  return SizedBox(
    height: 180,
    child: Center(
      // Example structure:
      /*
      SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(maximum: 12),
        series: <ChartSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: teamHoursData,
            xValueMapper: (ChartData data, _) => data.day,
            yValueMapper: (ChartData data, _) => data.actual,
            color: kPrimaryBlue,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      )
      */
      child: Text(
        'Syncfusion Bar Chart Placeholder\n(Team Hours vs Target)',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[500]),
      ),
    ),
  );
}

Widget _buildSyncfusionPieChart() {
  return SizedBox(
    height: 180,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,

          // Example structure:
          /*
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<PieData, String>(
                dataSource: pieData,
                xValueMapper: (PieData data, _) => data.category,
                yValueMapper: (PieData data, _) => data.count,
                pointColorMapper: (PieData data, _) => data.color,
                dataLabelSettings: const DataLabelSettings(isVisible: false),
                radius: '100%',
              )
            ],
          ),
          */
          child: Text(
            'Syncfusion Pie Chart Placeholder',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var data in pieData)
              _pieLegendItem('${data.category}: ${data.count}', data.color),
          ],
        ),
      ],
    ),
  );
}

Widget _buildEstVsActual() {
  return Column(
    children: [
      for (int i = 0; i < varianceList.length; i++) ...[
        _varianceRow(varianceList[i]),
        if (i < varianceList.length - 1)
          const Divider(height: 16, thickness: 0.5, color: Color(0xFFD9D9D9)),
      ],
    ],
  );
}

Widget _varianceRow(VarianceData data) {
  final variance = data.actual - data.est;
  final varianceText = '${variance > 0 ? '+' : ''}${variance}h';
  final varianceColor = variance > 0 ? kPieRed : kPrimaryBlue;

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.service,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              data.client,
              style: const TextStyle(fontSize: 11, color: Color(0xFFA0A0A0)),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Est: ${data.est}h | Actual: ${data.actual}h',
              style: const TextStyle(fontSize: 12, color: Color(0xFF6A6A6A)),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: varianceColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                varianceText,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildApprovalSLA() {
  return Column(
    children: [
      for (int i = 0; i < funnelList.length; i++) ...[
        _slaFunnelRow(funnelList[i]),
        if (i < funnelList.length - 1) const SizedBox(height: 16),
      ],
    ],
  );
}

Widget _slaFunnelRow(FunnelData data) {
  String percentageText = '${(data.percentage * 100).toInt()}%';
  final progressValue = data.entries / funnelList.first.entries;

  return Row(
    children: [
      Expanded(
        flex: 2,
        child: Text(
          data.status,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progressValue,
            color: kPrimaryBlue,
            backgroundColor: kTargetGrey,
            minHeight: 12,
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: Text(
          '${data.entries} entries ($percentageText)',
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF6A6A6A),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}

Widget _chartCard(String title, Widget content, {Widget? headerActions}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xFFD9D9D9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            if (headerActions != null) headerActions,
          ],
        ),
        const SizedBox(height: 16),
        content,
      ],
    ),
  );
}

Widget _pieLegendItem(String label, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(width: 3, height: 12, color: color),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color(0xFF0A0A0A)),
        ),
      ],
    ),
  );
}

Widget buildChartsAndFunnelSection() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Column(
          children: <Widget>[
            _chartCard(
              'Team Hours vs Target (Daily)',
              _buildSyncfusionBarChart(),
              headerActions: const Icon(
                Icons.visibility_outlined,
                size: 18,
                color: Color(0xFF0A0A0A),
              ),
            ),
            const SizedBox(height: 24),
            _chartCard(
              'Est vs Actual Variance by Service',
              _buildEstVsActual(),
              headerActions: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      const SizedBox(width: 24),
      Expanded(
        flex: 1,
        child: Column(
          children: <Widget>[
            _chartCard(
              'Screenshot Coverage Distribution',
              _buildSyncfusionPieChart(),
              headerActions: const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            _chartCard(
              'Approval SLA Funnel',
              _buildApprovalSLA(),
              headerActions: const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    ],
  );
}
