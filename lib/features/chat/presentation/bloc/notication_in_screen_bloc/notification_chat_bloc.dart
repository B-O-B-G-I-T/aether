import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/message_entity.dart';

part 'notification_chat_event.dart';
part 'notification_chat_state.dart';

class NotificationChatBloc extends Bloc<NotificationChatEvent, NotificationChatState> {
  final List<MessageEntity> _unreadMessages = [];
  final List<MessageEntity> _activeSnackBars = [];

  NotificationChatBloc() : super(NotificationChatInitial()) {
    on<NewMessageReceived>(_onNewMessageReceived);
    on<ClearNotification>(_onClearNotification);
    on<DismissSnackBar>(_onDismissSnackBar);
  }

  void _onNewMessageReceived(NewMessageReceived event, Emitter<NotificationChatState> emit) {
    _unreadMessages.add(event.message);
    _activeSnackBars.add(event.message);
    emit(NotificationChatLoaded(unreadMessages: List.from(_unreadMessages)));
  }

  void _onClearNotification(ClearNotification event, Emitter<NotificationChatState> emit) {
    _unreadMessages.clear();
    _activeSnackBars.clear();
    emit(NotificationChatLoaded(unreadMessages: []));
  }

  void _onDismissSnackBar(DismissSnackBar event, Emitter<NotificationChatState> emit) {
    _activeSnackBars.remove(event.message);
    emit(NotificationChatLoaded(unreadMessages: List.from(_unreadMessages)));
  }

  List<MessageEntity> get activeSnackBars => List.from(_activeSnackBars);
}
