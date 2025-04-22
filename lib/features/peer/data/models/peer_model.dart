import '../../../../core/constants/peer_constant.dart';
import '../../domain/entities/peer_entity.dart';

class PeerModel extends PeerEntity {
  const PeerModel({
    required super.peer,
  });

  factory PeerModel.fromJson({required Map<String, dynamic> json}) {
    return PeerModel(
      peer: json[kPeer],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kPeer: peer,
    };
  }
}
