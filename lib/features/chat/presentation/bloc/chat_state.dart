part of 'chat_bloc.dart';

@immutable
sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatConnected extends ChatState {
  final NearbyService nearbyService;
  final List<MessageEntity> messages;

  const ChatConnected({required this.nearbyService, required this.messages});

  @override
    List<Object?> get props => [messages];


  ChatConnected copyWith({List<MessageEntity>? messages}) {
    return ChatConnected(nearbyService: nearbyService, messages: messages ?? this.messages);
  }
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
