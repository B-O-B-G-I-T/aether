part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserEvent extends UserEvent {

  GetUserEvent();
}

class SetUserEvent extends UserEvent {
  final UserParams userParams;

  SetUserEvent({required this.userParams});
}

class DeleteUserEvent extends UserEvent {
  DeleteUserEvent();
}
