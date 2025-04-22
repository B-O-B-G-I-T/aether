import '../../../../core/params/peer_params.dart';
import '../models/peer_model.dart';

abstract class PeerRemoteDataSource {
  Future<PeerModel>   getPeer({required PeerParams peerParams});
}

class PeerRemoteDataSourceImpl implements PeerRemoteDataSource {

  PeerRemoteDataSourceImpl();

  @override
  Future<PeerModel> getPeer({required PeerParams peerParams}) async {
    
    return PeerModel( peer: 'Peer 1');
  }
}
