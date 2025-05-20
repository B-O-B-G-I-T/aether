import 'package:aether/core/constants/chat_constants.dart';

import '../../../../commun/peer_config/data/datasources/database_config.dart';
import '../../../../core/params/conversation_params.dart';
import '../../../../service_locator.dart';
import '../models/conversation_model.dart';

abstract class ConversationLocalDataSource {
  Future<void> saveConversation({required ConversationModel? conversationToCache});
  Future<List<ConversationModel>> getConversations();
  Future<ConversationModel> getConversation({required GetConversationParams conversationParams});
  
}



class ConversationLocalDataSourceImpl implements ConversationLocalDataSource {
  final DatabaseConfig _database;

  ConversationLocalDataSourceImpl() : _database = sl<DatabaseConfig>();

  @override
  Future<void> saveConversation({required ConversationModel? conversationToCache}) async {
    final db = await _database.database;
    await db.insert('conversations', conversationToCache?.toJson() ?? {});
  }

  @override
  Future<List<ConversationModel>> getConversations() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('conversations');
    return List.generate(maps.length, (i) => ConversationModel.fromJson(json: maps[i]));
  }

  @override
  Future<ConversationModel> getConversation({required GetConversationParams conversationParams}) async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('conversations', where: '$kSenderId = ? OR $kReceiverId = ?', whereArgs: [conversationParams.senderId, conversationParams.receiverId]);
    return ConversationModel.fromJson(json: maps.first);
  }
}
