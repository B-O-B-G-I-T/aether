import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

class PeerParams {
  
  final String peerId;
  PeerParams({required this.peerId});
}

class InvitePeerParams {
  final Device device;
  InvitePeerParams({required this.device});
}
