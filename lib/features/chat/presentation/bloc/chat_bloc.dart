import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../../../commun/config/peer_config/presentation/bloc/peer_config_bloc.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
part 'chat_event.dart';
part 'chat_state.dart';

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(_onSendMessage);
    on<InitializeP2PEvent>(_onInitializeP2P);
    on<MessageReceivedEvent>(_onMessageReceived);
  }

  final List<MessageEntity> _messages = [];

  Future<void> _onInitializeP2P(InitializeP2PEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final nearbyService = sl<PeerConfigBloc>().state;
      if (nearbyService is PeerConfigInitialised) {
        emit(ChatConnected(nearbyService: nearbyService.nearbyService, messages: []));
      } else {
        emit(ChatError('Failed to initialize P2P connection'));
      }
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
