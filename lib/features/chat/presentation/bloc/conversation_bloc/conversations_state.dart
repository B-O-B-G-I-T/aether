part of 'conversations_bloc.dart';

sealed class ConversationsState extends Equatable {
  const ConversationsState();
  
  @override
  List<Object> get props => [];
}

final class ConversationsInitial extends ConversationsState {}

final class ConversationsLoading extends ConversationsState {}

final class ConversationsLoaded extends ConversationsState {
  final List<ConversationEntity> conversations;

  const ConversationsLoaded({required this.conversations});

  @override
  List<Object> get props => [conversations];
}

final class ConversationsError extends ConversationsState {
  final Failure failure;

  const ConversationsError(this.failure);

  @override
  List<Object> get props => [failure];
}