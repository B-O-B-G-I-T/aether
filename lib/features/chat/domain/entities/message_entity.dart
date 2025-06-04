import '../../data/models/message_model.dart';

class MessageEntity {
  final String id;
  final String content;
  final DateTime timestamp;
  final String type;
  final String conversationId;

  MessageEntity({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.type,
    required this.conversationId,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'],
      content: json['content'],
      conversationId: json['conversationId'],
      timestamp: json['timestamp'],
      type: json['type'],
    );
  }

  MessageModel toModel() {
    return MessageModel(
      id: id,
      content: content,
      conversationId: conversationId,
      timestamp: timestamp,
      type: type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'conversationId': conversationId,
      'timestamp': timestamp,
      'type': type,
    };
  }

}
