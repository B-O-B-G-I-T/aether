import 'dart:convert';
import 'package:aether/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/chat_constants.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../models/message_model.dart';

abstract class ChatLocalDataSource {
  Future<void> saveMessage({required MessageModel message});
  Future<List<MessageModel>> getMessages();
  Future<List<MessageModel>> getMessagesByPeer({required PeerEntity peer});
  Future<void> clearMessages();
}


class ChatLocalDataSourceImpl implements ChatLocalDataSource {

  ChatLocalDataSourceImpl();

  @override
  Future<void> saveMessage({required MessageModel message}) async {
    final List<MessageModel> messages = await getMessages();
    messages.add(message);
    await sl<SharedPreferences>().setString(cachedMessages, json.encode(messages.map((m) => m.toJson()).toList()));
  }

  @override
  Future<List<MessageModel>> getMessages() async {
    final jsonString = sl<SharedPreferences>().getString(cachedMessages);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => MessageModel.fromJson(json: json)).toList();
    }
    return [];
  }

  @override
  Future<List<MessageModel>> getMessagesByPeer({required PeerEntity peer}) async {
    final List<MessageModel> messages = await getMessages();
    return messages.where((message) => message.senderId == peer.device.deviceId || message.receiverId == peer.device.deviceId).toList();
  }

  @override
  Future<void> clearMessages() async {
    await sl<SharedPreferences>().remove(cachedMessages);
  }
}
