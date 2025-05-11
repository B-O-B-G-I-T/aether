import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';

import '../../../../core/constants/peer_constant.dart';

class PeerEntity {
  final Device device;
  final String? pathImageProfile;
  final String? myLastStartEncodeImage;

  PeerEntity({required this.device, this.pathImageProfile, this.myLastStartEncodeImage});

  factory PeerEntity.fromJson(Map<String, dynamic> json) {
    final String deviceId = json[kPeerId];
    final String deviceName = json[kPeerName];
    final String deviceState = json[kState];
    final String? deviceDescription = json[kPeerDescription];

    return PeerEntity(
      device: Device(deviceId, deviceName, deviceState, deviceDescription: deviceDescription),
      pathImageProfile: json[kPeerPathImageProfile],
      myLastStartEncodeImage: json[kPeerMyLastStartEncodeImage],
    );
  }

  Map<String, dynamic> toJson() {
    final deviceJson = device.toJson();
    final String deviceId = deviceJson[kPeerId];
    final String deviceName = deviceJson[kPeerName];
    final String deviceState = deviceJson[kState];
    final String? deviceDescription = deviceJson[kPeerDescription];
    return {
      kPeerId: deviceId,
      kPeerName: deviceName,
      kState: deviceState,
      kPeerDescription: deviceDescription,
      kPeerPathImageProfile: pathImageProfile,
      kPeerMyLastStartEncodeImage: myLastStartEncodeImage,
    };
  }
}
