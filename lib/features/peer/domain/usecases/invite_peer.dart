import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/peer_entity.dart';
import '../repositories/peer_repository.dart';

class InvitePeer implements UseCase<List<PeerEntity>, InvitePeerParams> {
  InvitePeer();

  @override
  Future<Either<Failure, List<PeerEntity> >> call({
    required InvitePeerParams param,
  }) async {
    return await sl<PeerRepository>().invitePeer(invitePeerParams: param);
  }
}
