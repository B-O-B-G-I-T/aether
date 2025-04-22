import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/peer_repository.dart';
import '../datasources/peer_local_data_source.dart';
import '../datasources/peer_remote_data_source.dart';
import '../models/peer_model.dart';

class PeerRepositoryImpl implements PeerRepository {
  PeerRepositoryImpl();

  @override
  Future<Either<Failure, PeerModel>> getPeer({required PeerParams peerParams}) async {

      try {
        PeerModel remotePeer = await sl<PeerRemoteDataSource>().getPeer(peerParams: peerParams);

        sl<PeerLocalDataSource>().cachePeer(); // peerToCache: remotePeer

        return Right(remotePeer);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    
    }
  }

