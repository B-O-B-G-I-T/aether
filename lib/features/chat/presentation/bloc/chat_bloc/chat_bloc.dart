import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/chat_params.dart';
import '../../../../../core/params/peer_params.dart';
import '../../../../peer/domain/entities/peer_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/get_conversation_messages.dart';
import '../../../domain/usecases/init_chat.dart';
import '../../../domain/usecases/send_message.dart';
import '../notication_in_screen_bloc/notification_chat_bloc.dart';
part 'chat_event.dart';
part 'chat_state.dart';

// Bloc
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<InitializeP2PEvent>(_onInitializeP2P);
    on<SendMessageEvent>(_onSendMessage);
    on<GetConversationMessagesEvent>(_onGetConversationMessages);
  }

  final List<MessageEntity> _messages = [];

  Future<void> _onInitializeP2P(InitializeP2PEvent event, Emitter<ChatState> emit) async {
    try {
      emit(ChatLoading());
      final result = await sl<InitChat>().call(param: PeerParams(peerId: event.receiverId));

      await result.fold(
        (failure) async {
          emit(ChatError(failure));
        },
        (streamMessages) async {
          emit(ChatLoaded(messages: List.from(_messages)));

          await for (final messages in streamMessages) {
            if (!emit.isDone) {
              _messages.addAll(messages);

              // Notifier le bloc de notification pour chaque nouveau message
              for (final message in messages) {
                sl<NotificationChatBloc>().add(NewMessageReceived(message));
               
              }

              emit(ChatLoaded(messages: List.from(_messages)));
            }
          }
        },
      );
    } catch (e) {
      emit(ChatError(ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      final result = await sl<SendMessage>().call(param: event.message);

      result.fold(
        (failure) {
          emit(ChatError(failure));
        },
        (message) {
          emit(ChatLoading());

          _messages.add(message);
          emit(ChatLoaded(messages: List.from(_messages)));
        },
      );
    } catch (e) {
      emit(ChatError(ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onGetConversationMessages(GetConversationMessagesEvent event, Emitter<ChatState> emit) async {
    try {
      _messages.clear();
      final messages = await sl<GetConversationMessages>().call(param: GetConversationMessagesParams(peer: event.peer));

      messages.fold(
        (failure) {
          emit(ChatError(failure));
        },
        (messages) {
          if (messages.isNotEmpty) {
            _messages.addAll(messages);
          }
          emit(ChatLoaded(messages: List.from(_messages)));
        },
      );
    } catch (e) {
      emit(ChatError(ServerFailure(errorMessage: e.toString())));
    }
  }
}
