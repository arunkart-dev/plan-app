class ChatMessageModel {
  int? id;
  final String text;
  final bool isUser;
  final DateTime createdAt;

  ChatMessageModel({
    this.id,
    required this.text,
    required this.isUser,
    required this.createdAt,
  });

  // ---------------------------
  // SQLite mapper (1 / 0)
  // ---------------------------
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'text': text,
      'is_user': isUser ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // ---------------------------
  // Supabase mapper (true / false)
  // ---------------------------
  Map<String, dynamic> toSupabaseMap(String userId) {
    return {
      'id': id,
      'text': text,
      'is_user': isUser,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId, // optional but recommended
    };
  }

  // ---------------------------
  // From DB (works for both)
  // ---------------------------
  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'],
      text: map['text'],
      isUser: map['is_user'] == 1 || map['is_user'] == true,
      createdAt: DateTime.parse(map['created_at']),
    );
  }
}
