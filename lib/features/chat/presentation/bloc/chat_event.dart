part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent  {}

class InitializeP2PEvent extends ChatEvent  {}

class SendMessageEvent extends ChatEvent {
  final String content;
  final String receiverId;

  SendMessageEvent({required this.content, required this.receiverId});

}

class MessageReceivedEvent extends ChatEvent {
  final MessageEntity message;

  MessageReceivedEvent(this.message);

}
