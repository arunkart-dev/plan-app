import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:provider/provider.dart';

class PriorityPieChart extends StatelessWidget {
  const PriorityPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();

    final done = provider.priorityCompletedCount.toDouble();
    final pending = provider.priorityPendingCount.toDouble();

    if (done + pending == 0) {
      return const SizedBox(
        height: 180,
        child: Center(child: Text("No priority data yet")),
      );
    }

    return SizedBox(
      height: 180,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 40,
          sectionsSpace: 2,
          sections: [
            PieChartSectionData(
              value: done,
              title: "Done",
              radius: 60,
            ),
            PieChartSectionData(
              value: pending,
              title: "Pending",
              radius: 60,
            ),
          ],
        ),
      ),
    );
  }
}
