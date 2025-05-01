import 'package:sqflite/sqflite.dart';
import '../../../../service_locator.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../models/message_model.dart';
import '../../../../commun/peer_config/data/datasources/database_config.dart';

abstract class ChatLocalDataSource {
  Future<void> saveMessage({required MessageModel message});
  Future<List<MessageModel>> getMessages();
  Future<List<MessageModel>> getMessagesByPeer({required PeerEntity peer});
  Future<void> clearMessages();
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final DatabaseConfig _database;

  ChatLocalDataSourceImpl() : _database = sl<DatabaseConfig>();

  @override
  Future<void> saveMessage({required MessageModel message}) async {
    final db = await _database.database;
    await db.insert('messages', message.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<MessageModel>> getMessages() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('messages');
    return List.generate(maps.length, (i) => MessageModel.fromJson(json: maps[i]));
  }

  @override
  Future<List<MessageModel>> getMessagesByPeer({required PeerEntity peer}) async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'messages',
      where: 'sender_id = ? OR receiver_id = ?',
      whereArgs: [peer.device.deviceId, peer.device.deviceId],
    );
    return List.generate(maps.length, (i) => MessageModel.fromJson(json: maps[i]));
  }

  @override
  Future<void> clearMessages() async {
    final db = await _database.database;
    await db.delete('messages');
  }
}
