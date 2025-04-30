import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

class PeerEntity {
  final Device device;
  final String? description;
  final String? pathImageProfile;
  final String? myLastStartEncodeImage;

  PeerEntity({required this.device, required this.description, this.pathImageProfile, this.myLastStartEncodeImage});

  factory PeerEntity.fromJson(Map<String, dynamic> json) {
    return PeerEntity(
      device: Device.fromJson(json['device']),
      description: json['description'],
      pathImageProfile: json['pathImageProfile'],
      myLastStartEncodeImage: json['myLastStartEncodeImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device': device.toJson(),
      'description': description,
      'pathImageProfile': pathImageProfile,
      'myLastStartEncodeImage': myLastStartEncodeImage,
    };
  }
}
