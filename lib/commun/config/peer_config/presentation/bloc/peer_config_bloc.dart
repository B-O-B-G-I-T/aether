import 'package:aether/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:meta/meta.dart';
import '../../../../../core/params/user_params.dart';
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

      result.fold((failure) => emit(PeerConfigError(failure.toString())), (nearbyService) => emit(PeerConfigInitialised(nearbyService)));
    } catch (e) {
      emit(PeerConfigError(e.toString()));
    }
  }
}
