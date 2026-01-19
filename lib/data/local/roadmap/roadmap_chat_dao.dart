import '../core/db_helper.dart';
import '../../../model/chat_message_model.dart';

class RoadmapChatDao {
  Future<int> insertMessage(ChatMessageModel msg) async {
    final db = await DBHelper.database;
    return await db.insert('roadmap_chat', msg.toSqliteMap());
  }

  Future<List<ChatMessageModel>> getAllMessages() async {
    final db = await DBHelper.database;
    final result = await db.query(
      'roadmap_chat',
      orderBy: 'createdAt ASC',
    );
    return result.map((e) => ChatMessageModel.fromMap(e)).toList();
  }

  Future<void> clearChat() async {
    final db = await DBHelper.database;
    await db.delete('roadmap_chat');
  }
}
