import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../entities/peer_entity.dart';


abstract class PeerRepository {
  Future<Either<Failure, Stream<List<PeerEntity>>>> getCheckAround({
    required PeerParams peerParams,
  });
  Future<Either<Failure, List<PeerEntity>>> invitePeer({
    required InvitePeerParams invitePeerParams,
  });
  Future<Either<Failure, List<PeerEntity>>> disconnectPeer({
    required PeerParams peerParams,
  });
}
