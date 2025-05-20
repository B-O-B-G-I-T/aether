import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../peer/domain/entities/peer_entity.dart';


abstract class UserRepository {
  Future<Either<Failure, PeerEntity?>> getUser();
  Future<Either<Failure, PeerEntity>> setUser({required SavePeersParams userParams});
  Future<Either<Failure, void>> disconnect();
}
