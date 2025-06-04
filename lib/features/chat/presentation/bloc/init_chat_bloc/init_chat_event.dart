part of 'init_chat_bloc.dart';

@immutable
sealed class InitChatEvent  {}

class InitializeP2PEvent extends InitChatEvent  {
  final String receiverId;

  InitializeP2PEvent({required this.receiverId});
}


