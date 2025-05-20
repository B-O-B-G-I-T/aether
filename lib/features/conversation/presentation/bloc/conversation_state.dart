part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

final class ConversationLoading extends ConversationState {}

final class ConversationLoaded extends ConversationState {
  final List<ConversationEntity> conversationEntity;

  ConversationLoaded({required this.conversationEntity});

}

final class ConversationError extends ConversationState {
  final Failure failure;

  ConversationError({required this.failure});
}
