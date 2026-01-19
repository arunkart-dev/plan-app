import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressChart extends StatelessWidget {
  final List<double> points;

  const ProgressChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    // 🛑 Guard: not enough data to draw chart
    if (points.length < 2) {
      return const SizedBox(
        height: 220,
        child: Center(
          child: Text("Complete tasks to see progress"),
        ),
      );
    }

    return SizedBox(
      height: 520,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          minY: 0,
          maxY: points.reduce((a, b) => a > b ? a : b) + 1,
          lineBarsData: [
            LineChartBarData(
              spots: points
                  .asMap()
                  .entries
                  .map(
                    (e) => FlSpot(
                      e.key.toDouble(),
                      e.value,
                    ),
                  )
                  .toList(),
              isCurved: true,
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.4),
                    Colors.blue.withOpacity(0.05),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
        // 🔑 FORCE REBUILD WHEN DATA CHANGES
        key: ValueKey(points.length.toString() + points.last.toString()),
      ),
    );
  }
}
