import 'package:aether/core/params/user_params.dart';
import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/get_initialisation.dart';
part 'chat_event.dart';
part 'chat_state.dart';

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<InitializeP2PEvent>(_onInitializeP2P);
    on<SendMessageEvent>(_onSendMessage);
    on<MessageReceivedEvent>(_onMessageReceived);
  }

  final List<MessageEntity> _messages = [];

  Future<void> _onInitializeP2P(InitializeP2PEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final result = await sl.get<GetInitialisation>().call(param: UserParams(displayName: 'displayName', description: 'description'));

      result.fold((failure) => emit(ChatError(failure.toString())), (nearbyService) => emit(ChatConnected(nearbyService, _messages)));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final message = MessageEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: event.content,
        senderId: 'currentUserId', // À remplacer par l'ID réel de l'utilisateur
        receiverId: event.receiverId,
        timestamp: DateTime.now(),
      );

      await sl.get<ChatRepository>().sendMessage(message);
      _messages.add(message);

      switch (state) {
        case ChatConnected connected:
          emit(connected.copyWith(messages: _messages));
        case _:
          break;
      }
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatState> emit) {
    _messages.add(event.message);

    switch (state) {
      case ChatConnected connected:
        emit(connected.copyWith(messages: _messages));
      case _:
        break;
    }
  }

  @override
  Future<void> close() {
    sl.get<ChatRepository>().closeConnection();
    return super.close();
  }
}
