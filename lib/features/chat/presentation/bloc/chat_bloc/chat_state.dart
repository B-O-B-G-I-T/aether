part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;
  const ChatLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class ChatError extends ChatState {
  final Failure failure;

  const ChatError(this.failure);
}
