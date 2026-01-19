import 'package:flutter/material.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Make Plan",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Version: 1.0.0"),

            SizedBox(height: 20),
            Text(
              "About",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text(
              "Make Plan helps you organize your daily tasks, track progress, "
              "set priorities, and achieve your goals efficiently.",
            ),

            SizedBox(height: 20),
            Text(
              "Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text("• Task management\n"
                "• Progress tracking\n"
                "• Smart planning\n"
                "• Reminders\n"
                "• Community sharing"),

            SizedBox(height: 20),
            Text(
              "Developed by",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text("Arunkarthik"),
          ],
        ),
      ),
    );
  }
}
