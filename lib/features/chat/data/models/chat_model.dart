import '../../../../core/constants/chat_constants.dart';
import '../../domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.chat,
  });

  factory ChatModel.fromJson({required Map<String, dynamic> json}) {
    return ChatModel(
      chat: json[kChat],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kChat: chat,
    };
  }
}
