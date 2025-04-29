import 'package:bloc/bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/peer_entity.dart';
import '../../domain/usecases/disconnect_peer.dart';
import '../../domain/usecases/get_check_around.dart';
import '../../domain/usecases/invite_peer.dart';

part 'peer_event.dart';
part 'peer_state.dart';

class PeerBloc extends Bloc<PeerEvent, PeerState> {
  PeerBloc() : super(PeerInitial()) {
    on<PeerEvent>((event, emit) {});
    on<GetCheckAroundEvent>(_onGetCheckAround);
    on<InvitePeerEvent>(_onInvitePeer);
    on<DisconnectPeerEvent>(_onDisconnectPeer);
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
              emit(PeerLoaded(peers: peers));
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
}
