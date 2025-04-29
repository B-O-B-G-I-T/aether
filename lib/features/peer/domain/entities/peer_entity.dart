import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

class PeerEntity {
  final Device device;
  final String? description;
  final String? pathImageProfile;
  final String? myLastStartEncodeImage;

  PeerEntity({
    required this.device,
    required this.description,
    this.pathImageProfile,
    this.myLastStartEncodeImage,
  });
}