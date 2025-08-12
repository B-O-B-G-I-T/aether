import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../../../core/errors/app_logger.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/peer_config_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../features/chat/presentation/bloc/init_chat_bloc/init_chat_bloc.dart';
import '../../../../features/conversation/presentation/bloc/conversation_bloc.dart';
import '../../../../features/user/presentation/bloc/user_bloc.dart';
import '../../domain/usecases/disconnect_peer_config.dart';
import '../../domain/usecases/get_init_peer_config.dart';
part 'peer_config_event.dart';
part 'peer_config_state.dart';

class PeerConfigBloc extends Bloc<PeerConfigEvent, PeerConfigState> {
  PeerConfigBloc() : super(PeerConfigInitial()) {
    on<PeerConfigEvent>((event, emit) {
      // implement event handler
    });
    on<GetInitPeerConfigEvent>(_onGetInitPeerConfig);
    on<DisconnectPeerConfigEvent>(_onDisconnect);
  }

  Future<void> _onGetInitPeerConfig(GetInitPeerConfigEvent event, Emitter<PeerConfigState> emit) async {
    try {
      AppLogger.i('PeerConfigBloc: État initial - Chargement en cours');
      emit(PeerConfigLoading());

      final userBloc = sl.get<UserBloc>();
      userBloc.add(GetUserEvent());
      await _waitForUserLoaded(userBloc: userBloc);


      final user = userBloc.state;

      if (user is UserLoaded) {
        AppLogger.i('PeerConfigBloc: Utilisateur chargé - Initialisation de la configuration');
        final result = await sl.get<GetInitPeerConfig>().call(
          param: SavePeersParams(peer: user.user),
        );

        result.fold(
          (failure) {
            AppLogger.e('PeerConfigBloc: Erreur lors de l\'initialisation - ${failure.errorMessage}');
            emit(PeerConfigError(failure));
          },
          (nearbyService) {
            AppLogger.i('PeerConfigBloc: Configuration initialisée avec succès');
            emit(PeerConfigInitialised(nearbyService));
          },
        );

        // wait for peer loaded
        final peerBloc = sl.get<PeerBloc>();
        peerBloc.add(GetCheckAroundEvent());
        await _waitForPeerAroundLoaded(peerBloc: peerBloc);

        // wait for conversation loaded
        final conversationBloc = sl.get<ConversationBloc>();
        conversationBloc.add(GetConversationsEvent());
        await _waitForConversationLoaded(conversationBloc: conversationBloc);

        // wait for chat loaded
        final chatBloc = sl.get<InitChatBloc>();
        chatBloc.add(InitializeP2PEvent(receiverId: 'receiverId'));
        await _waitForChatLoaded(chatBloc: chatBloc);


        // is not connected
      } else if (user is UserNotLoaded) {
        AppLogger.i('PeerConfigBloc: Utilisateur non chargé - Redirection vers la page de création');
        emit(PeerConfigUserNotLoaded());
      } else {
        AppLogger.e('PeerConfigBloc: État utilisateur inattendu - ${user.runtimeType}');
        emit(PeerConfigError(ServerFailure(errorMessage: 'État utilisateur inattendu')));
      }
    } catch (e) {
      AppLogger.e('PeerConfigBloc: Erreur non gérée - ${e.toString()}');
      emit(PeerConfigError(ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onDisconnect(DisconnectPeerConfigEvent event, Emitter<PeerConfigState> emit) async {
    final nearbyService = (state as PeerConfigInitialised).nearbyService;
    emit(PeerConfigLoading());
    final result = await sl.get<DisconnectPeerConfig>().call(param: DisconnectPeerConfigParams(nearbyService: nearbyService));
    result.fold(
      (failure) {
        AppLogger.e('PeerConfigBloc: Erreur lors de la déconnexion - ${failure.errorMessage}');
        emit(PeerConfigError(failure));
      },
      (nearbyService) {
        emit(PeerConfigUserNotLoaded());
      },
    );
  }

  Future<void> _waitForUserLoaded({required UserBloc userBloc}) async {
    await for (final state in userBloc.stream) {
      if (state is UserLoaded || state is UserError || state is UserNotLoaded) break;
    }
  }

  Future<void> _waitForPeerAroundLoaded({required PeerBloc peerBloc}) async {
    await for (final state in peerBloc.stream) {
      if (state is PeerLoaded || state is PeerError) break;
    }
  }

  Future<void> _waitForChatLoaded({required InitChatBloc chatBloc}) async {
    await for (final state in chatBloc.stream) {
      if (state is InitChatLoaded || state is InitChatError) break;
    }
  }

  Future<void> _waitForConversationLoaded({required ConversationBloc conversationBloc}) async {
    await for (final state in conversationBloc.stream) {
      if (state is ConversationLoaded || state is ConversationError) break;
    }
  }

}
