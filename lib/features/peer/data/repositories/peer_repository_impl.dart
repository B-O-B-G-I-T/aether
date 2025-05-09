import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/peer_entity.dart';
import '../../domain/repositories/peer_repository.dart';
import '../datasources/peer_local_data_source.dart';
import '../datasources/peer_remote_data_source.dart';
import '../models/peer_model.dart';

class PeerRepositoryImpl implements PeerRepository {
  PeerRepositoryImpl();

  @override
  Future<Either<Failure, Stream<List<PeerModel>>>> getCheckAround({required PeerParams peerParams}) async {
    try {
      final Stream<List<PeerModel>> remotePeer = await sl<PeerRemoteDataSource>().getCheckAround(peerParams: peerParams);

      return Right(remotePeer);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeerModel>>> invitePeer({required InvitePeerParams invitePeerParams}) async {
    try {
      final List<PeerModel> remotePeer = await sl<PeerRemoteDataSource>().invitePeer(invitePeerParams: invitePeerParams);

      return Right(remotePeer);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeerModel>>> disconnectPeer({required PeerParams peerParams}) async {
    try {
      final List<PeerModel> remotePeer = await sl<PeerRemoteDataSource>().disconnectPeer(peerParams: peerParams);

      return Right(remotePeer);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> savePeers({required SavePeersParams savePeersParams}) async {
    try {
      await sl<PeerLocalDataSource>().savePeer(savePeersParams);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeerEntity>>> getPeers() async {
    try {
      final List<PeerEntity> remotePeer = await sl<PeerLocalDataSource>().getPeers();

      return Right(remotePeer);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PeerEntity>>> getPeer({required GetPeerParams getPeerParams}) async {
    try {
      final List<PeerEntity> remotePeer = await sl<PeerLocalDataSource>().getPeerByDeviceId(getPeerParams.peerId);

        return Right(remotePeer);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
