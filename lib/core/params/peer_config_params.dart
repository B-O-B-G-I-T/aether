import 'package:flutter_nearby_connections/flutter_nearby_connections.dart' show NearbyService;

class PeerConfigParams {
  final String template;
  final String name;
  final String description;
  final String image;
  final String url;

  const PeerConfigParams({
    required this.template,
    required this.name,
    required this.description,
    required this.image,
    required this.url,
  }); 
}

class DisconnectPeerConfigParams {
  final NearbyService nearbyService;

  const DisconnectPeerConfigParams({
    required this.nearbyService,
  });
}
