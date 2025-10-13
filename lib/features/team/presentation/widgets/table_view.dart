import 'package:dna_taskflow_prime/features/team/data/models/analytics_models.dart';
import 'package:flutter/material.dart';

class TableView extends StatelessWidget {
  const TableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics Data Table',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          DailyHoursTable(),
          SizedBox(height: 40),
          CoverageTable(),
        ],
      ),
    );
  }
}

class DailyHoursTable extends StatelessWidget {
  const DailyHoursTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daily Hours vs Target',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(1.0),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.5),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _buildTableRow(
              isHeader: true,
              day: 'Day',
              target: 'Target Hours',
              actual: 'Actual Hours',
              variance: 'Variance',
            ),

            ...dailyHoursData.map((data) {
              final variance = (data.actual - data.target).toStringAsFixed(1);
              return _buildTableRow(
                day: data.day,
                target: data.target.toStringAsFixed(0),
                actual: data.actual.toStringAsFixed(1),
                variance: variance,
              );
            }),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow({
    required String day,
    required String target,
    required String actual,
    required String variance,
    bool isHeader = false,
  }) {
    final TextStyle style = isHeader
        ? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
        : const TextStyle(color: Colors.black87);

    Color varianceColor = Colors.black87;
    if (!isHeader) {
      final double varValue = double.parse(variance);
      if (varValue > 0) {
        varianceColor = Colors.green;
      } else if (varValue < 0) {
        varianceColor = Colors.red;
      }
    }
    final TextStyle varianceStyle = isHeader
        ? style
        : TextStyle(color: varianceColor, fontWeight: FontWeight.w500);

    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isHeader ? Colors.grey.shade300 : Colors.grey.shade200,
            width: isHeader ? 2.0 : 1.0,
          ),
        ),
      ),
      children: [
        _buildTableCell(day, style: style, padding: isHeader ? 15 : 10),

        _buildTableCell(target, style: style, padding: isHeader ? 15 : 10),

        _buildTableCell(actual, style: style, padding: isHeader ? 15 : 10),

        _buildTableCell(
          variance,
          style: varianceStyle,
          padding: isHeader ? 15 : 10,
        ),
      ],
    );
  }
}

class CoverageTable extends StatelessWidget {
  const CoverageTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coverage Distribution',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2.0),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.5),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _buildCoverageTableRow(
              isHeader: true,
              range: 'Coverage Range',
              count: 'Count',
              percentage: 'Percentage',
            ),
            ...coverageData.map((data) {
              final totalCount = coverageData.fold(
                0,
                (sum, item) => sum + item.count,
              );
              final percentage = (data.count / totalCount) * 100;

              return _buildCoverageTableRow(
                range: data.range,
                count: data.count.toString(),
                percentage: '${percentage.toStringAsFixed(1)}%',
              );
            }),
          ],
        ),
      ],
    );
  }

  TableRow _buildCoverageTableRow({
    required String range,
    required String count,
    required String percentage,
    bool isHeader = false,
  }) {
    final TextStyle style = isHeader
        ? const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)
        : const TextStyle(color: Colors.black87);

    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isHeader ? Colors.grey.shade300 : Colors.grey.shade200,
            width: isHeader ? 2.0 : 1.0,
          ),
        ),
      ),
      children: [
        _buildTableCell(range, style: style, padding: isHeader ? 15 : 10),

        _buildTableCell(count, style: style, padding: isHeader ? 15 : 10),

        _buildTableCell(percentage, style: style, padding: isHeader ? 15 : 10),
      ],
    );
  }
}

Widget _buildTableCell(
  String text, {
  required TextStyle style,
  double padding = 10,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: padding, horizontal: 8),
    child: Text(text, style: style, textAlign: TextAlign.left),
  );
}
