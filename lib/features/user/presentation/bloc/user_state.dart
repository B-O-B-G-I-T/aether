part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final PeerEntity user;

  UserLoaded({required this.user});
}

final class UserNotLoaded extends UserState {}

final class UserError extends UserState {
  final Failure failure;

  UserError({required this.failure});
}
