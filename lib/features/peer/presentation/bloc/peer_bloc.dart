import 'package:bloc/bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/conversation_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../../conversation/domain/entities/conversation_entity.dart';
import '../../../conversation/presentation/bloc/conversation_bloc.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../domain/entities/peer_entity.dart';
import '../../domain/usecases/disconnect_peer.dart';
import '../../domain/usecases/get_check_around.dart';
import '../../domain/usecases/get_peer.dart';
import '../../domain/usecases/get_peers.dart';
import '../../domain/usecases/invite_peer.dart';

part 'peer_event.dart';
part 'peer_state.dart';

class PeerBloc extends Bloc<PeerEvent, PeerState> {
  PeerBloc() : super(PeerInitial()) {
    on<PeerEvent>((event, emit) {});
    on<GetCheckAroundEvent>(_onGetCheckAround);
    on<InvitePeerEvent>(_onInvitePeer);
    on<DisconnectPeerEvent>(_onDisconnectPeer);
    on<GetKnownPeersEvent>(_onGetPeers);
    on<GetPeerEvent>(_onGetPeer);
  }

  Future<void> _onGetCheckAround(GetCheckAroundEvent event, Emitter<PeerState> emit) async {
    try {
      final result = await sl<GetCheckAround>().call(param: PeerParams(peerId: 'peerId'));

      await result.fold(
        (failure) async {
          if (!emit.isDone) {
            emit(PeerError(failure: failure));
          }
        },
        (streamPeers) async {
          await for (final peers in streamPeers) {
            if (!emit.isDone) {
              // ici metre la logique des peers
              final connectedPeers = <PeerEntity>[];
              final peersAround = <PeerEntity>[];
              if (peers.isNotEmpty) {
                for (final peer in peers) {
                  if (peer.device.state == SessionState.connected) {
                    connectedPeers.add(peer);

                    sl<UserBloc>().add(SetUserEvent(userParams: SavePeersParams(peer: peer)));
                    sl<ConversationBloc>().add(
                      SaveConversationEvent(
                        conversationParams: SaveConversationParams(
                          conversation: ConversationEntity(peerId: peer.device.deviceId, lastMessage: '', lastActivity: ''),
                        ),
                      ),
                    );
                  }

                  peersAround.add(peer);
                }
              }
              emit(PeerLoaded(peers: peersAround, connectedPeers: connectedPeers));
            }
          }
        },
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(PeerError(failure: ServerFailure(errorMessage: e.toString())));
      }
    }
  }

  Future<void> _onInvitePeer(InvitePeerEvent event, Emitter<PeerState> emit) async {
    /* TODO: faire une liste des divice connectée
 devices =
            devices.map((d) {
              if (d.deviceId == device.deviceId) {
                d.state = SessionState.connecting;
              }
              return d;
            }).toList();
    */
    try {
      final result = await sl<InvitePeer>().call(param: InvitePeerParams(device: event.device));
      await result.fold((failure) async {
        if (!emit.isDone) {
          emit(PeerError(failure: failure));
        }
      }, (success) async {});
    } catch (e) {
      if (!emit.isDone) {
        emit(PeerError(failure: ServerFailure(errorMessage: e.toString())));
      }
    }
  }

  Future<void> _onDisconnectPeer(DisconnectPeerEvent event, Emitter<PeerState> emit) async {
    try {
      final result = await sl<DisconnectPeer>().call(param: PeerParams(peerId: event.device.deviceId));
      await result.fold((failure) async {
        if (!emit.isDone) {
          emit(PeerError(failure: failure));
        }
      }, (success) async {});
    } catch (e) {
      emit(PeerError(failure: ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onGetPeers(GetKnownPeersEvent event, Emitter<PeerState> emit) async {
    try {
      final resultKnownedPeers = await sl<GetPeers>().call(param: null);
      await resultKnownedPeers.fold(
        (failure) async {
          if (!emit.isDone) {
            emit(PeerError(failure: failure));
          }
        },
        (peers) async {
          if (!emit.isDone) {
            emit(PeerLoaded(peers: peers));
          }
        },
      );
    } catch (e) {
      emit(PeerError(failure: ServerFailure(errorMessage: e.toString())));
    }
  }

  Future<void> _onGetPeer(GetPeerEvent event, Emitter<PeerState> emit) async {
    try {
      final result = await sl<GetPeer>().call(param: GetPeerParams(peerId: event.peerId));
      await result.fold(
        (failure) async {
          if (!emit.isDone) {
            emit(PeerError(failure: failure));
          }
        },
        (success) async {
          if (!emit.isDone) {
            emit(PeerLoaded(peers: success));
          }
        },
      );
    } catch (e) {
      emit(PeerError(failure: ServerFailure(errorMessage: e.toString())));
    }
  }
}
