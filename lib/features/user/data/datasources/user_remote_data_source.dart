import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../core/params/peer_params.dart';
import '../../../peer/data/models/peer_model.dart';

abstract class UserRemoteDataSource {
  Future<PeerModel>   getUser({required SavePeersParams userParams});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  UserRemoteDataSourceImpl();

  @override
  Future<PeerModel> getUser({required SavePeersParams userParams}) async {
    
    return PeerModel(device: Device(userParams.peer.device.deviceId, userParams.peer.device.deviceName, userParams.peer.device.state, deviceDescription: userParams.peer.device.deviceDescription), myLastStartEncodeImage: userParams.peer.myLastStartEncodeImage,pathImageProfile: userParams.peer.pathImageProfile, );
  }
}
