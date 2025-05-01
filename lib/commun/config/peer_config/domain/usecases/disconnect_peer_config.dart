import 'package:dartz/dartz.dart';
import '../../../../../core/constants/usecase/usecase.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/peer_config_params.dart';
import '../../../../../service_locator.dart';
import '../repositories/peer_config_repository.dart';

class DisconnectPeerConfig implements UseCase<void, DisconnectPeerConfigParams> {
  DisconnectPeerConfig();

  @override
  Future<Either<Failure, void>> call({
    required DisconnectPeerConfigParams param,
  }) async {
    return await sl<PeerConfigRepository>().disconnect(params: param);
  }
}
