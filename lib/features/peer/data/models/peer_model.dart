import '../../../../core/constants/peer_constant.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../domain/entities/peer_entity.dart';

class PeerModel extends PeerEntity {
  PeerModel({
    required super.device,
    super.description,
    super.pathImageProfile,
    super.myLastStartEncodeImage,
  });

  factory PeerModel.fromJson({required Map<String, dynamic> json}) {
    return PeerModel(
      device: Device(json[kPeerId], json[kPeerName], json[kState],),

      description: json[kPeerDescription],
      pathImageProfile: json[kPeerPathImageProfile] ?? '',
      myLastStartEncodeImage: json[kPeerMyLastStartEncodeImage] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      kPeerDescription: description,
      kPeerPathImageProfile: pathImageProfile ?? '',
      kPeerMyLastStartEncodeImage: myLastStartEncodeImage ?? '',
    };
  }
}
