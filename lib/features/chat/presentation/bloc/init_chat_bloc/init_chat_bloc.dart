import 'package:aether/features/chat/domain/usecases/save_message.dart';
import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/peer_params.dart';
import '../../../domain/usecases/init_chat.dart';
import '../chat_bloc/chat_bloc.dart';
import '../notication_in_screen_bloc/notification_chat_bloc.dart';
part 'init_chat_event.dart';
part 'init_chat_state.dart';

// Bloc
class InitChatBloc extends Bloc<InitChatEvent, InitChatState> {
  InitChatBloc() : super(InitChatInitial()) {
    on<InitializeP2PEvent>(_onInitializeP2P);

  }


  Future<void> _onInitializeP2P(InitializeP2PEvent event, Emitter<InitChatState> emit) async {
    try {
      emit(InitChatLoading());
      final result = await sl<InitChat>().call(param: PeerParams(peerId: event.receiverId));

      await result.fold(
        (failure) async {
          emit(InitChatError(failure));
        },
        (streamMessages) async {
          emit(InitChatLoaded());

          await for (final messages in streamMessages) {
            if (!emit.isDone) {
              // enregistrer les messages dans la base de données
              for (final message in messages) {
                sl<SaveMessage>().call(param: message);

                // ajouter le message dans le bloc de chat qui gere les messages si il est dans la conversation
                sl<ChatBloc>().add(AddNewMessageIfInConversation(message: message));

                // Notifier le bloc de notification pour chaque nouveau message
                sl<NotificationChatBloc>().add(NewMessageReceived(message));

              }


              emit(InitChatLoaded());
            }
          }
        },
      );
    } catch (e) {
      emit(InitChatError(ServerFailure(errorMessage: e.toString())));
    }
  }
}
