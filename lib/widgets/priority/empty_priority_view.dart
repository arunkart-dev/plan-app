import 'package:flutter/material.dart';

class EmptyPriorityView extends StatelessWidget {
  const EmptyPriorityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.star_border, size: 60, color: Colors.grey),
              SizedBox(height: 12),
              Text(
                "No Priority Tasks Yet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "Mark important tasks with ⭐ to see them here.\n"
                "This helps you stay focused on what truly matters.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
