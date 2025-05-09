import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../entities/peer_entity.dart';
import '../repositories/peer_repository.dart';

class GetPeer implements UseCase<List<PeerEntity>, GetPeerParams> {
  GetPeer();

  @override
  Future<Either<Failure, List<PeerEntity>>> call({
    required GetPeerParams param,
  }) async {
    return await sl<PeerRepository>().getPeer(getPeerParams: param);
  }
}
