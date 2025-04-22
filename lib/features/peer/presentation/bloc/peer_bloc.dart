import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'peer_event.dart';
part 'peer_state.dart';

class PeerBloc extends Bloc<PeerEvent, PeerState> {
  PeerBloc() : super(PeerInitial()) {
    on<PeerEvent>((event, emit) {
      // implement event handler
    });
  }
}
