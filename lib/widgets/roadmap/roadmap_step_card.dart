import 'package:flutter/material.dart';
import 'package:make_plan/model/roadmap_step_model.dart';
import 'package:make_plan/viewmodel/roadmap_provider.dart';
import 'package:provider/provider.dart';

class RoadmapStepCard extends StatelessWidget {
  final RoadmapStep step;
  final int index;

  const RoadmapStepCard({
    super.key,
    required this.step,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<RoadmapProvider>();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: step.isCompleted,
          onChanged: (_) => provider.toggleStep(index),
        ),
        title: Text(
          step.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
                step.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(step.description),
        trailing: Icon(
          step.isCompleted ? Icons.check_circle : Icons.flag,
          color: step.isCompleted ? Colors.green : Colors.blueGrey,
        ),
      ),
    );
  }
}
