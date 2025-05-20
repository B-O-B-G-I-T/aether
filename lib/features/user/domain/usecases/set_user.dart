import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../repositories/user_repository.dart';

class SetUser implements UseCase<PeerEntity, SavePeersParams> {
  SetUser();

  @override
  Future<Either<Failure, PeerEntity>> call({
    required SavePeersParams param,
  }) async {
    return await sl<UserRepository>().setUser(userParams: param);
  }
}
