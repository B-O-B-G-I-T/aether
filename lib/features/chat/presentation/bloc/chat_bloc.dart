import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/usecases/init_chat.dart';
part 'chat_event.dart';
part 'chat_state.dart';

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<InitializeP2PEvent>(_onInitializeP2P);
    on<SendMessageEvent>(_onSendMessage);
  }

  final List<MessageEntity> _messages = [];

  Future<void> _onInitializeP2P(InitializeP2PEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatConnected(messages: []));
      final result = await sl<InitChat>().call(param: PeerParams(peerId: event.receiverId));

      await result.fold(
        (failure) async {
          emit(ChatError(failure.toString()));
        },
        (streamMessages) async {
          await for (final messages in streamMessages) {
            if (!emit.isDone) {
              _messages.addAll(messages);
              emit(ChatConnected(messages: List.from(_messages)));
            }
          }
        },
      );
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
        type: 'text',
      );

      await sl.get<ChatRepository>().sendMessage(
        params: SendMessageParams(
          content: event.content,
          receiverId: event.receiverId,
          senderId: 'currentUserId',
          type: 'text',
          timestamp: DateTime.now().toIso8601String(),
        ),
      );
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
}
