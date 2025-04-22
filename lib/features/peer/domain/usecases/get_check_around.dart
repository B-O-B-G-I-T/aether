import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/peer_entity.dart';
import '../repositories/peer_repository.dart';

class GetPeer implements UseCase<PeerEntity, PeerParams> {
  GetPeer();

  @override
  Future<Either<Failure, PeerEntity>> call({
    required PeerParams param,
  }) async {
    return await sl<PeerRepository>().getPeer(peerParams: param);
  }
}
