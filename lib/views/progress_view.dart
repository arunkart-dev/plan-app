import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/progress_provider.dart';
import '../viewmodel/todo_provider.dart';
import '../widgets/progress/progress_chart.dart';
import '../widgets/progress/progress_stat_card.dart';
import '../widgets/progress/consistency_badge.dart';
import '../widgets/progress/progress_summary.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.watch<TodoProvider>();
    final progressProvider = context.watch<ProgressProvider>();

    // Sync todos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      progressProvider.updateTodos(todoProvider.todos);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Progress',style: TextStyle(fontSize: 25),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressChart(points: progressProvider.progressPoints),
            const SizedBox(height: 16),
      
            Row(
              children: [
                ProgressStatCard(
                  title: "Completed",
                  value: progressProvider.completedTasks,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                ProgressStatCard(
                  title: "Pending",
                  value: progressProvider.pendingTasks,
                  color: Colors.red,
                ),
              ],
            ),
      
            const SizedBox(height: 12),
            ConsistencyBadge(score: progressProvider.consistencyScore),
            const SizedBox(height: 12),
            ProgressSummary(text: progressProvider.summaryText),
          ],
        ),
      ),
    );
  }
}
