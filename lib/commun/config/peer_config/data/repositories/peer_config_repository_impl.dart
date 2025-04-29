import 'package:dartz/dartz.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/peer_config_params.dart';
import '../../../../../core/params/user_params.dart';
import '../../../../../service_locator.dart';
import '../../domain/repositories/peer_config_repository.dart';
import '../datasources/peer_config_local_data_source.dart';
import '../datasources/peer_config_remote_data_source.dart';
import '../models/peer_config_model.dart';

class PeerConfigRepositoryImpl implements PeerConfigRepository {
  PeerConfigRepositoryImpl();


  @override
  Future<Either<Failure, NearbyService>> initializeP2PConnection ({required UserParams userParams}) async {
    try {
      
      NearbyService nearbyService = await sl<PeerConfigRemoteDataSource>().init(userParams: userParams);

      return Right(nearbyService);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PeerConfigModel>> getPeerConfig({required PeerConfigParams peerConfigParams}) async {

      try {
        PeerConfigModel remotePeerConfig = await sl<PeerConfigRemoteDataSource>().getPeerConfig(peerConfigParams: peerConfigParams);

        sl<PeerConfigLocalDataSource>().cachePeerConfig(); // peerConfigToCache: remotePeerConfig

        return Right(remotePeerConfig);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    
    }
  }

