import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/chat_constants.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../../../commun/peer_config/data/datasources/database_config.dart';

abstract class ConversationsLocalDataSource {
  Future<List<ConversationEntity>> getConversations();
  Future<void> addConversation(ConversationEntity conversation);
  Future<void> updateConversation(ConversationEntity conversation);
  Future<void> deleteConversation(ConversationEntity conversation);
}

class ConversationsLocalDataSourceImpl implements ConversationsLocalDataSource {
  final DatabaseConfig _database;

  ConversationsLocalDataSourceImpl() : _database = sl<DatabaseConfig>();

  @override
  Future<List<ConversationEntity>> getConversations() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('conversations');
    return List.generate(maps.length, (i) => ConversationEntity.fromJson(maps[i]));
  }

  @override
  Future<ConversationEntity> addConversation(ConversationEntity conversation) async {
    final db = await _database.database;
    await db.insert('conversations', conversation.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return conversation;
  }

  @override
  Future<ConversationEntity> updateConversation(ConversationEntity conversation) async {
    final db = await _database.database;
    await db.update('conversations', conversation.toJson(), where: '$kId = ?', whereArgs: [conversation.id]);
    return conversation;
  }

  @override
  Future<ConversationEntity> deleteConversation(ConversationEntity conversation) async {
    final db = await _database.database;
    await db.delete('conversations', where: '$kId = ?', whereArgs: [conversation.id]);
    return conversation;
  }
}
