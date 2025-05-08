import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/chat_params.dart';
import '../../../../../service_locator.dart';
import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/usecases/conversations/add_conversation.dart';
import '../../../domain/usecases/conversations/delete_conversation.dart';
import '../../../domain/usecases/conversations/get_conversations.dart';
import '../../../domain/usecases/conversations/update_conversation.dart';

part 'conversations_event.dart';
part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  ConversationsBloc() : super(ConversationsInitial()) {
    on<LoadConversations>(_onLoadConversations);
    on<AddConversation>(_onAddConversation);
    on<UpdateConversation>(_onUpdateConversation);
    on<DeleteConversation>(_onDeleteConversation);
  }

  final List<ConversationEntity> _conversations = [];

  Future<void> _onLoadConversations(LoadConversations event, Emitter<ConversationsState> emit) async {
    try {
      emit(ConversationsLoading());
      final conversations = await sl<GetConversations>().call(param: GetConversationsParams());
      conversations.fold(
        (failure) {
          emit(ConversationsError(failure));
        },
        (conversations) {
          _conversations.addAll(conversations);
          emit(ConversationsLoaded(conversations: _conversations));
        },
      );
    } catch (e) {
      emit(ConversationsError(ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onAddConversation(AddConversation event, Emitter<ConversationsState> emit) async {
    try {
      if (_conversations.any((conversation) => conversation.peerId == event.conversation.peerId)) {
        return;
      }
      final result = await sl<AddConversationUsecase>().call(param: UpdateConversationParams(conversation: event.conversation));
      result.fold(
        (failure) {
          emit(ConversationsError(failure));
        },
        (conversation) {
          _conversations.add(event.conversation);
          emit(ConversationsLoaded(conversations: _conversations));
        },
      );
    } catch (e) {
      emit(ConversationsError(ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onUpdateConversation(UpdateConversation event, Emitter<ConversationsState> emit) async {
    try {
      final result = await sl<UpdateConversationUsecase>().call(param: UpdateConversationParams(conversation: event.conversation));
      result.fold(
        (failure) {
          emit(ConversationsError(failure));
        },
        (conversation) {
          _conversations.add(event.conversation);
          emit(ConversationsLoaded(conversations: _conversations));
        },
      );
    } catch (e) {
      emit(ConversationsError(ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onDeleteConversation(DeleteConversation event, Emitter<ConversationsState> emit) async {
    try {
      final result = await sl<DeleteConversationUsecase>().call(param: UpdateConversationParams(conversation: event.conversation));
      result.fold(
        (failure) {
          emit(ConversationsError(failure));
        },
        (conversation) {
          _conversations.remove(event.conversation);
          emit(ConversationsLoaded(conversations: _conversations));
        },
      );
    } catch (e) {
      emit(ConversationsError(ServerFailure(errorMessage: e.toString())));
    }
  }
}
