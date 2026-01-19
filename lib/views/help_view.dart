import 'package:flutter/material.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _helpTile(
            title: "How to add a task?",
            desc:
                "Go to the Tasks tab and tap the + button to create a new task.",
          ),
          _helpTile(
            title: "How to track progress?",
            desc:
                "Open the Progress tab to see your completed and pending tasks.",
          ),
          _helpTile(
            title: "How to set priority?",
            desc:
                "While creating a task, choose priority level: High, Medium, or Low.",
          ),
          _helpTile(
            title: "How to contact support?",
            desc:
                "Send your queries to: support@makeplan.app",
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "We’re here to help you succeed 💙",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget _helpTile({required String title, required String desc}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(title),
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(desc),
          )
        ],
      ),
    );
  }
}
