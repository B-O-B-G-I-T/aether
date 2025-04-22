import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../entities/peer_entity.dart';


abstract class PeerRepository {
  Future<Either<Failure, PeerEntity>> getPeer({
    required PeerParams peerParams,
  });
}
