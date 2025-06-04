import 'package:aether/features/chat/domain/entities/message_entity.dart';
import '../../../../core/constants/chat_constants.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.content,
    required super.timestamp,
    required super.type,
    required super.conversationId,
  });

  factory MessageModel.fromJson({required Map<String, dynamic> json}) {
    return MessageModel(
      id: json[kId],
      content: json[kContent],
      conversationId: json[kConversationId],
      timestamp: DateTime.parse(json[kTimestamp]),
      type: json[kType],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {kId: id, kContent: content, kConversationId: conversationId, kTimestamp: timestamp.toIso8601String(), kType: type};
  }
}
