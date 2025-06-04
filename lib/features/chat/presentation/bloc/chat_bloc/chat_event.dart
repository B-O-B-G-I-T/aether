part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final SendMessageParams message;

  const SendMessageEvent({required this.message});
}

class AddNewMessageIfInConversation extends ChatEvent {
  final MessageEntity message;

  const AddNewMessageIfInConversation({required this.message});
}

class GetConversationMessagesEvent extends ChatEvent {
  final PeerEntity peer;

  const GetConversationMessagesEvent({required this.peer});
}
