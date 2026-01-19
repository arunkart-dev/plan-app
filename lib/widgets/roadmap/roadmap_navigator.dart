import 'package:flutter/material.dart';
import 'package:make_plan/views/roadmap_chat_view.dart';

class RoadmapNavigator extends StatelessWidget {
  const RoadmapNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FloatingActionButton.extended(
      elevation: 2,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      icon: const Icon(
        Icons.auto_awesome_rounded,
        size: 20,
      ),
      label: const Text(
        'Roadmap assistant',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RoadmapChatView(),
          ),
        );
      },
    );
  }
}
