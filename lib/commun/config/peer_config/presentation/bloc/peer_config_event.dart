part of 'peer_config_bloc.dart';

@immutable
sealed class PeerConfigEvent {}

class GetInitPeerConfigEvent extends PeerConfigEvent {}
