import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/peer_entity.dart';
import '../repositories/peer_repository.dart';

class GetPeers implements UseCase<List<PeerEntity>, void> {
  GetPeers();

  @override
  Future<Either<Failure, List<PeerEntity>>> call({
    required void param,
  }) async {
    return await sl<PeerRepository>().getPeers();
  }
}
