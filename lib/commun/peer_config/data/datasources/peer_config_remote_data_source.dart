import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../core/params/peer_config_params.dart';
import '../../../../core/params/peer_params.dart';

abstract class PeerConfigRemoteDataSource {
  Future<NearbyService> init({required SavePeersParams peerParams});
  Future<void> disconnect({required DisconnectPeerConfigParams params});
}

class PeerConfigRemoteDataSourceImpl implements PeerConfigRemoteDataSource {
  PeerConfigRemoteDataSourceImpl();

  @override
  Future<NearbyService> init({required SavePeersParams peerParams}) async {
    final NearbyService nearbyService = await initiateNearbyService(peerParams);

    return nearbyService;
  }

  // Initiating NearbyService to start the connection
  Future<NearbyService> initiateNearbyService(SavePeersParams peerParams) async {
    NearbyService nearbyService = NearbyService();
    await nearbyService.init(
      serviceType: 'mp-connection',

      deviceName: peerParams.peer.device.deviceName,
      description: peerParams.peer.device.deviceDescription,
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
  Future<void> disconnect({required DisconnectPeerConfigParams params}) async {
    final NearbyService nearbyService = params.nearbyService;
    await nearbyService.stopAdvertisingPeer();
    await nearbyService.stopBrowsingForPeers();
  }
}
