part of 'conversations_bloc.dart';

sealed class ConversationsEvent extends Equatable {
  const ConversationsEvent();

  @override
  List<Object> get props => [];
}

class LoadConversations extends ConversationsEvent {}

class AddConversation extends ConversationsEvent {
  final ConversationEntity conversation;

  const AddConversation({required this.conversation});
}


class UpdateConversation extends ConversationsEvent {
  final ConversationEntity conversation;

  const UpdateConversation({required this.conversation});
}

class DeleteConversation extends ConversationsEvent {
  final ConversationEntity conversation;

  const DeleteConversation({required this.conversation});
}

