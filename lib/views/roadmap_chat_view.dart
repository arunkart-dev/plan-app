import 'package:flutter/material.dart';
import 'package:make_plan/viewmodel/roadmap_chat_provider.dart';
import 'package:make_plan/widgets/chatbot_roadmap/chat_bubble.dart';
import 'package:make_plan/widgets/chatbot_roadmap/chat_input.dart';
import 'package:provider/provider.dart';

class RoadmapChatView extends StatelessWidget {
  const RoadmapChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RoadmapChatProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Roadmap Bot"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.messages.length,
              itemBuilder: (context, index) {
                final msg = provider.messages[index];
                return ChatBubble(message: msg);
              },
            ),
          ),
          const ChatInput(),
        ],
      ),
    );
  }
}
