import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/user_params.dart';
import '../../../../service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class SetUser implements UseCase<UserEntity, UserParams> {
  SetUser();

  @override
  Future<Either<Failure, UserEntity>> call({
    required UserParams param,
  }) async {
    return await sl<UserRepository>().setUser(userParams: param);
  }
}
