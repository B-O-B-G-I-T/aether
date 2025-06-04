import 'package:aether/features/conversation/domain/entities/conversation_entity.dart';
import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/conversation_params.dart';
import '../../domain/usecases/get_conversation.dart';
import '../../domain/usecases/get_conversations.dart';
import '../../domain/usecases/save_conversation.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc() : super(ConversationInitial()) {
    on<ConversationEvent>((event, emit) {
      // implement event handler
    });
    on<GetConversationsEvent>((event, emit) => _getConversations(event, emit));
    on<SaveConversationEvent>((event, emit) => _saveConversation(event, emit));
    on<GetConversationEvent>((event, emit) => _getConversation(event, emit));
  }

  _getConversations(GetConversationsEvent event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());

    final result = await sl<GetConversations>().call(param: GetConversationsParams());
    result.fold(
      (failure) {
        emit(ConversationError(failure: failure));
      },
      (conversation) {

        emit(ConversationLoaded(conversationEntity: conversation));
      },
    );
  }

  _saveConversation(SaveConversationEvent event, Emitter<ConversationState> emit) async {
    
    emit(ConversationLoading());

    final result = await sl<SaveConversation>().call(param: event.conversationParams);
    result.fold(
      (failure) {
        emit(ConversationError(failure: failure));
      },
      (conversation) {
        if (state is ConversationLoaded) {
          final oldConversationEntity = (state as ConversationLoaded).conversationEntity;
          oldConversationEntity.add(event.conversationParams.conversation);
          emit(ConversationLoaded(conversationEntity: oldConversationEntity));
        }
      },
    );
  }

  _getConversation(GetConversationEvent event, Emitter<ConversationState> emit) async {
    emit(ConversationLoading());

    final result = await sl<GetConversation>().call(param: GetConversationParams(senderId: event.senderId, receiverId: event.receiverId));

    result.fold(
      (failure) {
        emit(ConversationError(failure: failure));
        final conversation = ConversationEntity(
          lastMessage: '',
          lastActivity: DateTime.now().toIso8601String(),
          peerId: event.senderId,
        );

        _saveConversation(SaveConversationEvent(conversationParams: SaveConversationParams(conversation: conversation)), emit);
      },
      (conversation) {
        emit(ConversationLoaded(conversationEntity: [conversation]));
      },
    );
  }
}