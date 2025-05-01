import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/params.dart';
import '../../../../service_locator.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUser implements UseCase<UserEntity?, NoParams> {
  GetUser();

  @override
  Future<Either<Failure, UserEntity?>> call({
    required NoParams param,
  }) async {
    return await sl<UserRepository>().getUser();
  }
}
