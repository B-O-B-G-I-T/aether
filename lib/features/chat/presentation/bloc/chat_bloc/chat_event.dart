part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent  {}

class InitializeP2PEvent extends ChatEvent  {
  final String receiverId;

  InitializeP2PEvent({required this.receiverId});
}

class SendMessageEvent extends ChatEvent {
  final String content;
  final String receiverId;

  SendMessageEvent({required this.content, required this.receiverId});

}

class GetConversationMessagesEvent extends ChatEvent {
  final PeerEntity peer;

  GetConversationMessagesEvent({required this.peer});
}

