import 'package:aether/features/chat/domain/entities/message_entity.dart';
import '../../../../core/constants/chat_constants.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.content,
    required super.senderId,
    required super.receiverId,
    required super.timestamp,
    required super.type,
  });

  factory MessageModel.fromJson({required Map<String, dynamic> json}) {
    return MessageModel(
      id: json[kId],
      content: json[kContent],
      senderId: json[kSenderId],
      receiverId: json[kReceiverId],
      timestamp: DateTime.parse(json[kTimestamp]),
      type: json[kType],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {kId: id, kContent: content, kSenderId: senderId, kReceiverId: receiverId, kTimestamp: timestamp.toIso8601String(), kType: type};
  }
}
