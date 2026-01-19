import 'package:flutter/material.dart';

class ProgressSummary extends StatelessWidget {
  final String text;

  const ProgressSummary({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
