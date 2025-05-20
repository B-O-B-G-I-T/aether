
import '../../features/conversation/domain/entities/conversation_entity.dart';

class ConversationParams {
  
  
  ConversationParams();
}

class SaveConversationParams extends ConversationParams {
  final ConversationEntity conversation;
  SaveConversationParams({required this.conversation});
}



class GetConversationsParams extends ConversationParams {
  GetConversationsParams();
}

class GetConversationParams extends ConversationParams {
  final String senderId;
  final String receiverId;
  GetConversationParams({required this.senderId, required this.receiverId});
}

