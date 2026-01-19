import 'package:flutter/material.dart';
import 'package:make_plan/model/planner_model.dart';
import 'package:make_plan/viewmodel/planner_provider.dart';
import 'package:provider/provider.dart';

class PlannerTaskTile extends StatelessWidget {
  final PlannerModel plan;

  const PlannerTaskTile({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<PlannerProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Checkbox(
          value: plan.isCompleted,
          onChanged: (_) => provider.togglePlan(plan.id!),
        ),
        title: Text(
          plan.title,
          style: TextStyle(
            decoration:
                plan.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: const Icon(Icons.schedule),
      ),
    );
  }
}
