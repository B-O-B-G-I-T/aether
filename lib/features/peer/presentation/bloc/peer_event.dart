part of 'peer_bloc.dart';

@immutable
sealed class PeerEvent {}

final class GetCheckAroundEvent extends PeerEvent {}

final class InvitePeerEvent extends PeerEvent {
  final Device device;

  InvitePeerEvent({required this.device});
}

final class DisconnectPeerEvent extends PeerEvent {
  final Device device;

  DisconnectPeerEvent({required this.device});
}


final class GetKnownPeersEvent extends PeerEvent {

}

final class GetPeerEvent extends PeerEvent {
  final String peerId;

  GetPeerEvent({required this.peerId});
}
class StartDiscovery extends PeerEvent {}

class StopDiscovery extends PeerEvent {}

class DiscoverDevices extends PeerEvent {}
