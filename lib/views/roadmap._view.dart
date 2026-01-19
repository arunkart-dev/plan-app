import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/roadmap_provider.dart';
import 'package:make_plan/widgets/roadmap/roadmap_flow.dart';
import 'package:make_plan/widgets/roadmap/roadmap_navigator.dart';
import 'package:make_plan/widgets/roadmap/roadmap_selector.dart';
import 'package:provider/provider.dart';

class RoadmapView extends StatelessWidget {
  const RoadmapView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RoadmapProvider>();
    final roadmap = provider.currentRoadmap;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Roadmap"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          const RoadmapSelector(),

          const SizedBox(height: 16),

          Expanded(
            child: roadmap == null
                ? const Center(
                    child: Text(
                      "Choose a roadmap to get started",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : RoadmapFlow(roadmap: roadmap),
          ),
        ],
      ),
      floatingActionButton: RoadmapNavigator(),
    );
  }
}
