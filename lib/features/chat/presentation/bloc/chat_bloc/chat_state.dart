part of 'chat_bloc.dart';

@immutable
sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageEntity> messages;

  const ChatLoaded({required this.messages});

  @override
  List<Object?> get props => [messages];

  ChatLoaded copyWith({List<MessageEntity>? messages}) {
    return ChatLoaded(messages: messages ?? this.messages);
  }
}

class ChatError extends ChatState {
  final Failure failure;

  const ChatError(this.failure);

  @override
  List<Object?> get props => [failure];
}
