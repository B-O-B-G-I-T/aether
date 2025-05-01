import 'package:dartz/dartz.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/peer_config_params.dart';
import '../../../../../core/params/user_params.dart';


abstract class PeerConfigRepository {
  Future<Either<Failure, NearbyService>> initializeP2PConnection ({required UserParams userParams});
  Future<Either<Failure, void>> disconnect({required DisconnectPeerConfigParams params});
}
