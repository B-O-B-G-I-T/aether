import 'dart:async';
import 'dart:io';
import 'package:aether/service_locator.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../commun/peer_config/presentation/bloc/peer_config_bloc.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/peer_params.dart';
import '../models/peer_model.dart';

abstract class PeerRemoteDataSource {
  Future<Stream<List<PeerModel>>> getCheckAround({required PeerParams peerParams});
  Future<List<PeerModel>> invitePeer({required InvitePeerParams invitePeerParams});
  Future<List<PeerModel>> disconnectPeer({required PeerParams peerParams});
}

class PeerRemoteDataSourceImpl implements PeerRemoteDataSource {
  PeerRemoteDataSourceImpl();

  @override
  Future<Stream<List<PeerModel>>> getCheckAround({required PeerParams peerParams}) async {
    try {
      final NearbyService nearbyService = (sl<PeerConfigBloc>().state as PeerConfigInitialised).nearbyService;

      final StreamController<List<PeerModel>> controller = StreamController();

      nearbyService.stateChangedSubscription(
        callback: (devicesList) async {
          final List<PeerModel> peers = [];

          for (var element in devicesList) {
            if (Platform.isAndroid) {
              if (element.state == SessionState.connected) {
                nearbyService.stopBrowsingForPeers();
              } else {
                nearbyService.startBrowsingForPeers();
              }
            }

            if (element.state == SessionState.connecting) {
              // Ici on force en "connected"
              // element.state = SessionState.connected;
            }

            peers.add(PeerModel(device: element));
          }

          controller.add(peers);
        },
      );

      return controller.stream;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<PeerModel>> invitePeer({required InvitePeerParams invitePeerParams}) async {
    // TODO: Faire une alerte lorsque l'on n'arrive pas a ce connecté

    final NearbyService nearbyService = (sl<PeerConfigBloc>().state as PeerConfigInitialised).nearbyService;
    final Device device = invitePeerParams.device;

    switch (device.state) {
      case SessionState.notConnected:
        await nearbyService.invitePeer(deviceID: device.deviceId, deviceName: device.deviceName, /*force: 'qr-force'*/);

        device.state = SessionState.connecting;
        break;
      case SessionState.connected:
        await nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.connecting:
        await nearbyService.disconnectPeer(deviceID: device.deviceId);
        break;
      case SessionState.tooFar:
        break;
    }

    return [];
  }

  @override
  Future<List<PeerModel>> disconnectPeer({required PeerParams peerParams}) async {
    final NearbyService nearbyService = (sl<PeerConfigBloc>().state as PeerConfigInitialised).nearbyService;
    final String deviceId = peerParams.peerId;
    await nearbyService.disconnectPeer(deviceID: deviceId);

    return [];
  }
}
