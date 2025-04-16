import 'package:aether/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({required super.id, required super.content, required super.senderId, required super.receiverId, required super.timestamp});
}

