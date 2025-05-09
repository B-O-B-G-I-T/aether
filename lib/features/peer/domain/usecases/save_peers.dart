import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../repositories/peer_repository.dart';

class SavePeers implements UseCase<void, SavePeersParams> {
  SavePeers();

  @override
  Future<Either<Failure, void>> call({
    required SavePeersParams param,
  }) async {
    return await sl<PeerRepository>().savePeers(savePeersParams: param);
  }
}
