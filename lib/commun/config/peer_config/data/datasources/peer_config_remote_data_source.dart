import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../../core/params/peer_config_params.dart';
import '../../../../../core/params/user_params.dart';
import '../models/peer_config_model.dart';

abstract class PeerConfigRemoteDataSource {
  Future<PeerConfigModel>   getPeerConfig({required PeerConfigParams peerConfigParams});
  Future<NearbyService> init({required UserParams userParams});
}

class PeerConfigRemoteDataSourceImpl implements PeerConfigRemoteDataSource {

  PeerConfigRemoteDataSourceImpl();

  
  @override
  Future<NearbyService> init({required UserParams userParams}) async {

    final NearbyService nearbyService = await initiateNearbyService(userParams);

    return nearbyService;
  }

// Initiating NearbyService to start the connection
  Future<NearbyService> initiateNearbyService( UserParams userParams) async {
    NearbyService nearbyService = NearbyService();
    await nearbyService.init(
      serviceType: 'mp-connection',

      deviceName: "mp-connection-${userParams.displayName}",
      description: userParams.description,
      strategy: Strategy.P2P_CLUSTER,
      callback: (isRunning) async {
        if (isRunning) {
          await startAdvertising(nearbyService);
          await startBrowsing(nearbyService);
        }
      },

    );
    await startAdvertising(nearbyService);
    await startBrowsing(nearbyService);

    return nearbyService;
  }

// Start discovering devices
  Future<void> startBrowsing(NearbyService nearbyService) async {
    await nearbyService.stopBrowsingForPeers();
    await nearbyService.startBrowsingForPeers();
  }

  Future<void> startAdvertising(NearbyService nearbyService) async {
    await nearbyService.stopAdvertisingPeer();
    await nearbyService.startAdvertisingPeer();
  }

  @override
  Future<PeerConfigModel> getPeerConfig({required PeerConfigParams peerConfigParams}) async {
    
    return PeerConfigModel( peerConfig: 'PeerConfig 1');
  }


}
