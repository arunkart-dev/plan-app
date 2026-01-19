import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlannerHeader extends StatelessWidget {
  const PlannerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEEE, dd MMM').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            today,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Plan your day. Win your day.",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
