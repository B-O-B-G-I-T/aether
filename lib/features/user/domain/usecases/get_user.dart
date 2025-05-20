import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/params.dart';
import '../../../../service_locator.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../repositories/user_repository.dart';

class GetUser implements UseCase<PeerEntity?, NoParams> {
  GetUser();

  @override
  Future<Either<Failure, PeerEntity?>> call({
    required NoParams param,
  }) async {
    return await sl<UserRepository>().getUser();
  }
}
