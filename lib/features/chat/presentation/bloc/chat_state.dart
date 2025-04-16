part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  
}


class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatConnected extends ChatState {
  final NearbyService nearbyService;
  final List<MessageEntity> messages;

  ChatConnected(this.nearbyService, this.messages);

  @override
  List<Object?> get props => [messages];


  ChatConnected copyWith({List<MessageEntity>? messages}) {
    return ChatConnected(nearbyService, messages ?? this.messages);
  }
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
