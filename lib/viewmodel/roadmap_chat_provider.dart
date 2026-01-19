import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:make_plan/data/local/roadmap/roadmap_chat_dao.dart';
import 'package:make_plan/services/supabase_service.dart';
import '../config/api_keys.dart';
import '../model/chat_message_model.dart';

class RoadmapChatProvider extends ChangeNotifier {
  final RoadmapChatDao _dao = RoadmapChatDao();
  final SupabaseService _supabase = SupabaseService();

  final List<ChatMessageModel> _messages = [];
  bool _isLoading = false;

  List<ChatMessageModel> get messages => _messages;
  bool get isLoading => _isLoading;

  // ================= LOAD =================
  Future<void> loadChats() async {
    // 1️⃣ SQLite first
    final data = await _dao.getAllMessages();
    _messages
      ..clear()
      ..addAll(data);
    notifyListeners();

    // 2️⃣ Try Supabase
    try {
      final remote = await _supabase.fetchChatMessages();
      _messages
        ..clear()
        ..addAll(remote);
      notifyListeners();
    } catch (_) {
      // offline → keep local data
    }
  }

  // ================= SEND MESSAGE =================
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // ---- USER MESSAGE ----
    final userMsg = ChatMessageModel(
      text: text,
      isUser: true,
      createdAt: DateTime.now(),
    );

    _messages.add(userMsg);
    notifyListeners();

    // SQLite
    await _dao.insertMessage(userMsg);

    // Supabase
    try {
      await _supabase.addChatMessage(userMsg);
    } catch (_) {}

    _isLoading = true;
    notifyListeners();

    try {
      final reply = await _getRoadmapFromGemini(text);

      // ---- BOT MESSAGE ----
      final botMsg = ChatMessageModel(
        text: reply,
        isUser: false,
        createdAt: DateTime.now(),
      );

      _messages.add(botMsg);
      notifyListeners();

      // SQLite
      await _dao.insertMessage(botMsg);

      // Supabase
      try {
        await _supabase.addChatMessage(botMsg);
      } catch (_) {}
    } catch (e) {
      final errorMsg = ChatMessageModel(
        text: "⚠️ Sorry, I couldn’t generate a roadmap right now.",
        isUser: false,
        createdAt: DateTime.now(),
      );

      _messages.add(errorMsg);
      notifyListeners();

      // SQLite
      await _dao.insertMessage(errorMsg);

      // Supabase
      try {
        await _supabase.addChatMessage(errorMsg);
      } catch (_) {}
    }

    _isLoading = false;
    notifyListeners();
  }

  // ================= GEMINI API =================
  Future<String> _getRoadmapFromGemini(String userInput) async {
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$geminiApiKey",
    );

    final prompt = """
You are a roadmap assistant.
Only generate ROADMAPS.

User request:
"$userInput"

Return in this format:

ROADMAP TITLE:
<Title>

STEPS:
1. Step title - short description
2. Step title - short description
3. Step title - short description
4. Step title - short description
5. Step title - short description
""";

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode != 200) {
      throw Exception("Gemini API error");
    }

    final data = jsonDecode(response.body);
    return data["candidates"][0]["content"]["parts"][0]["text"];
  }

  // ================= CLEAR CHAT =================
  Future<void> clearChat() async {
    // SQLite
    await _dao.clearChat();

    _messages.clear();
    notifyListeners();

    // Supabase (optional – clears only this user’s messages)
    try {
      await _supabase.clearChatMessages();
    } catch (_) {}
  }
}
