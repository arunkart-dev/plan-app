import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/roadmap_provider.dart';
import 'package:provider/provider.dart';

class RoadmapSelector extends StatelessWidget {
  const RoadmapSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.read<RoadmapProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _chip(
            theme,
            label: 'Study',
            onTap: provider.loadStudyRoadmap,
          ),
          const SizedBox(width: 12),
          _chip(
            theme,
            label: 'Career',
            onTap: provider.loadCareerRoadmap,
          ),
          const SizedBox(width: 12),
          _chip(
            theme,
            label: 'Fitness',
            onTap: provider.loadFitnessRoadmap,
          ),
        ],
      ),
    );
  }

  Widget _chip(
    ThemeData theme, {
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ),
    );
  }
}
