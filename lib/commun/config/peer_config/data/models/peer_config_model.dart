import '../../../../../core/constants/peer_config.dart';
import '../../domain/entities/peer_config_entity.dart';

class PeerConfigModel extends PeerConfigEntity {
  const PeerConfigModel({
    required super.peerConfig,
  });

  factory PeerConfigModel.fromJson({required Map<String, dynamic> json}) {
    return PeerConfigModel(
      peerConfig: json[kPeerConfig],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kPeerConfig: peerConfig,
    };
  }
}
