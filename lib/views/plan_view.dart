import 'package:flutter/material.dart';
import 'package:make_plan/model/planner_model.dart';
import 'package:make_plan/viewmodel/planner_provider.dart';
import 'package:make_plan/widgets/planner/empty_planner_view.dart';
import 'package:make_plan/widgets/planner/planner_header.dart';
import 'package:make_plan/widgets/planner/planner_task_tile.dart';
import 'package:provider/provider.dart';


class PlannerView extends StatelessWidget {
  const PlannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlannerProvider>();
    final plans = provider.todayPlans;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Planner"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          const PlannerHeader(),

          const SizedBox(height: 16),

          Expanded(
            child: plans.isEmpty
                ? const EmptyPlannerView()
                : ListView.builder(
                    itemCount: plans.length,
                    itemBuilder: (context, index) {
                      return PlannerTaskTile(plan: plans[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();
    final provider = context.read<PlannerProvider>();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Today’s Plan"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter task...",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                provider.addPlan(
                  PlannerModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: controller.text,
                    date: DateTime.now(),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
