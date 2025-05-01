import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../../../core/params/user_params.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/disconnect.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/set_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) {
      // implement event handler
    });
    on<GetUserEvent>(_onGetUser);
    on<SetUserEvent>(_onSetUser);
    on<DeleteUserEvent>(_onDeleteUser);

  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final user = await sl<GetUser>().call(param: NoParams());

    user.fold(
      (failure) {
        emit(UserError(failure: failure));
      },
      (user) {
        if (user != null) {
          emit(UserLoaded(user: user));
        } else {
          emit(UserNotLoaded());
        }
      },
    );
  }

  Future<void> _onSetUser(SetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final user = await sl<SetUser>().call(param: event.userParams);

    user.fold(
      (failure) {
        emit(UserError(failure: failure));
      },
      (user) {
        emit(UserLoaded(user: user));
      },
    );
  }

  Future<void> _onDeleteUser(DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final user = await sl<Disconnect>().call(param: NoParams());

    user.fold(
      (failure) {
        emit(UserError(failure: failure));
      },
      (user) {
        emit(UserNotLoaded());
      },
    );
  }
}
