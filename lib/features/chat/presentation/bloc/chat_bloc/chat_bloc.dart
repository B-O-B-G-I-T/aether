import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/chat_params.dart';
import '../../../../peer/domain/entities/peer_entity.dart';
import '../../../domain/entities/message_entity.dart';
import '../../../domain/usecases/get_conversation_messages.dart';
import '../../../domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});
    on<AddNewMessageIfInConversation>(_onAddNewMessageIfInConversation);
    on<SendMessageEvent>(_onSendMessage);
    on<GetConversationMessagesEvent>(_onGetConversationMessages);
  }

  final List<MessageEntity> _messages = [];

  // envoyer un message
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

  // ajouter un message
  Future<void> _onAddNewMessageIfInConversation(AddNewMessageIfInConversation event, Emitter<ChatState> emit) async {
    if (_messages.any((message) => message.id == event.message.id)) {
      _messages.add(event.message);
      emit(ChatLoaded(messages: List.from(_messages)));
    }
  }

  // récupérer les messages de la conversation
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
