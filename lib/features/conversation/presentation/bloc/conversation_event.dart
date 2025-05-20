part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}


class GetConversationsEvent extends ConversationEvent {
  GetConversationsEvent();
}

class GetConversationEvent extends ConversationEvent {
  final String senderId;
  final String receiverId;
  GetConversationEvent({required this.senderId, required this.receiverId});
}

class SaveConversationEvent extends ConversationEvent {
  final SaveConversationParams conversationParams;
  SaveConversationEvent({required this.conversationParams});
}
