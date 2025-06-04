part of 'init_chat_bloc.dart';

@immutable
sealed class InitChatState extends Equatable {
  const InitChatState();

  @override
  List<Object?> get props => [];
}

class InitChatInitial extends InitChatState {}

class InitChatLoading extends InitChatState {}

class InitChatLoaded extends InitChatState {

  const InitChatLoaded();
}

class InitChatError extends InitChatState {
  final Failure failure;

  const InitChatError(this.failure);

  @override
  List<Object?> get props => [failure];
}
