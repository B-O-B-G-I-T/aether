import 'package:aether/features/peer/presentation/bloc/peer_bloc.dart';
import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/user_params.dart';
import '../../../../../features/chat/presentation/bloc/chat_bloc.dart';
import '../../domain/usecases/get_init_peer_config.dart';

part 'peer_config_event.dart';
part 'peer_config_state.dart';

class PeerConfigBloc extends Bloc<PeerConfigEvent, PeerConfigState> {
  PeerConfigBloc() : super(PeerConfigInitial()) {
    on<PeerConfigEvent>((event, emit) {
      // implement event handler
    });
    on<GetInitPeerConfigEvent>(_onGetInitPeerConfig);
  }

  Future<void> _onGetInitPeerConfig(GetInitPeerConfigEvent event, Emitter<PeerConfigState> emit) async {
    try {
      emit(PeerConfigLoading());
      final result = await sl.get<GetInitPeerConfig>().call(param: UserParams(displayName: 'displayName', description: 'description'));

      result.fold(
        (failure) {
          emit(PeerConfigError(failure));
        },
        (nearbyService) {
          emit(PeerConfigInitialised(nearbyService));
        },
      );

      // wait for peer loaded
      final peerBloc = sl.get<PeerBloc>();
      peerBloc.add(GetCheckAroundEvent());
      await _waitForPeerAroundLoaded(peerBloc: peerBloc);

      // wait for chat loaded
      final chatBloc = sl.get<ChatBloc>();
      chatBloc.add(InitializeP2PEvent(receiverId: 'receiverId'));
      await _waitForChatLoaded(chatBloc: chatBloc);
    } catch (e) {
      emit(PeerConfigError(ServerFailure(errorMessage: e.toString())));
    }
  }


  Future<void> _waitForPeerAroundLoaded({required PeerBloc peerBloc}) async {
    await for (final state in peerBloc.stream) {
      if (state is PeerLoaded || state is PeerError) break;
    }
  }

  Future<void> _waitForChatLoaded({required ChatBloc chatBloc}) async {
    await for (final state in chatBloc.stream) {
      if (state is ChatLoaded || state is ChatError) break;
    }
  }
}
