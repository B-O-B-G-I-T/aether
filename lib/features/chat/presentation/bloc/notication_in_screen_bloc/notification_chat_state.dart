part of 'notification_chat_bloc.dart';

sealed class NotificationChatState extends Equatable {
  const NotificationChatState();

  @override
  List<Object> get props => [];
}

final class NotificationChatInitial extends NotificationChatState {}

final class NotificationChatLoading extends NotificationChatState {}

final class NotificationChatLoaded extends NotificationChatState {
  final List<MessageEntity> unreadMessages;

  const NotificationChatLoaded({required this.unreadMessages});

  @override
  List<Object> get props => [unreadMessages];
}

final class NotificationChatError extends NotificationChatState {
  final Failure failure;
  const NotificationChatError(this.failure);

  @override
  List<Object> get props => [failure];
}
