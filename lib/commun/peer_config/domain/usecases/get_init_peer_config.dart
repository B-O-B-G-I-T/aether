import 'package:dartz/dartz.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../repositories/peer_config_repository.dart';

class GetInitPeerConfig implements UseCase<NearbyService, SavePeersParams> {
  GetInitPeerConfig();

  @override
  Future<Either<Failure, NearbyService>> call({
    required SavePeersParams param,
  }) async {
    return await sl<PeerConfigRepository>().initializeP2PConnection(peerParams: param);
  }
}
