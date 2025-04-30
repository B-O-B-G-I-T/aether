part of 'notification_chat_bloc.dart';

sealed class NotificationChatEvent extends Equatable {
  const NotificationChatEvent();

  @override
  List<Object> get props => [];
}

class NewMessageReceived extends NotificationChatEvent {
  final MessageEntity message;

  const NewMessageReceived(this.message);

  @override
  List<Object> get props => [message];
}

class ClearNotification extends NotificationChatEvent {}

class DismissSnackBar extends NotificationChatEvent {
  final MessageEntity message;

  const DismissSnackBar(this.message);

  @override
  List<Object> get props => [message];
}
