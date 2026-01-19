import 'package:flutter/material.dart';
import 'package:make_plan/model/roadmap_model.dart';
import 'roadmap_step_card.dart';

class RoadmapFlow extends StatelessWidget {
  final RoadmapModel roadmap;

  const RoadmapFlow({super.key, required this.roadmap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      itemCount: roadmap.steps.length,
      itemBuilder: (context, index) {
        final step = roadmap.steps[index];
        final isLast = index == roadmap.steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- TIMELINE ----------
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 12),
              child: Column(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 60,
                      color: theme.colorScheme.primary.withOpacity(0.2),
                    ),
                ],
              ),
            ),

            // ---------- STEP CARD ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: RoadmapStepCard(
                  step: step,
                  index: index,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
