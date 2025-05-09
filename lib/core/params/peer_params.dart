import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import '../../features/peer/domain/entities/peer_entity.dart';

class PeerParams {
  
  final String peerId;
  PeerParams({required this.peerId});
}

class InvitePeerParams {
  final Device device;
  InvitePeerParams({required this.device});
}

class SavePeersParams {
  final PeerEntity peer;
  SavePeersParams({required this.peer});
}

class GetPeersParams {
  final String? peerId;
  GetPeersParams({this.peerId});
}

class GetPeerParams {
  final String peerId;
  GetPeerParams({required this.peerId});
}
