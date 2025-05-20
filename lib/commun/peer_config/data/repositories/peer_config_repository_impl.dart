import 'package:dartz/dartz.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/peer_config_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/peer_config_repository.dart';
import '../datasources/peer_config_remote_data_source.dart';

class PeerConfigRepositoryImpl implements PeerConfigRepository {
  PeerConfigRepositoryImpl();

  @override
  Future<Either<Failure, NearbyService>> initializeP2PConnection({required SavePeersParams peerParams}) async {
    try {
      NearbyService nearbyService = await sl<PeerConfigRemoteDataSource>().init(peerParams: peerParams);

      return Right(nearbyService);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect({required DisconnectPeerConfigParams params}) async {
    try {
      await sl<PeerConfigRemoteDataSource>().disconnect(params: params);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
