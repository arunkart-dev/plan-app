import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/todo_provider.dart';
import 'package:make_plan/widgets/priority/empty_priority_view.dart';
import 'package:make_plan/widgets/priority/priority_header.dart';
import 'package:make_plan/widgets/priority/priority_pie_chart.dart';
import 'package:make_plan/widgets/priority/priority_task_tile.dart';
import 'package:provider/provider.dart';
class Priority extends StatelessWidget {
  const Priority({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final priorityTodos = provider.priorityTodos;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Priority"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          const PriorityHeader(),

          const SizedBox(height: 16),

          const PriorityPieChart(),

          const SizedBox(height: 16),

          const Divider(),

          Expanded(
            child: priorityTodos.isEmpty
                ? const EmptyPriorityView()
                : ListView.builder(
                    itemCount: priorityTodos.length,
                    itemBuilder: (context, index) {
                      return PriorityTaskTile(
                        todo: priorityTodos[index],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
