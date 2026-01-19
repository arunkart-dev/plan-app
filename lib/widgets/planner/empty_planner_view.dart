import 'package:flutter/material.dart';

class EmptyPlannerView extends StatelessWidget {
  const EmptyPlannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.event_note, size: 60, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              "No Plans for Today",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Add a task to start planning your day.\n"
              "Small plans lead to big wins.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
