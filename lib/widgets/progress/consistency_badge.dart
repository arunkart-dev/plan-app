import 'package:flutter/material.dart';

class ConsistencyBadge extends StatelessWidget {
  final int score;

  const ConsistencyBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        "Consistency: $score%",
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor:
          score >= 70 ? Colors.green : score >= 40 ? Colors.orange : Colors.red,
    );
  }
}
