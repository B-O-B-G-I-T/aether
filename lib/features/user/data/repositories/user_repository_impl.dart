import 'package:aether/features/user/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/user_params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl();

  @override
  Future<Either<Failure, UserEntity?>> getUser() async {

      try {
        //UserModel remoteUser = await sl<UserRemoteDataSource>().getUser();

        final lastUser = await sl<UserLocalDataSource>().getLastUser();

      return Right(lastUser);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> setUser({required UserParams userParams}) async {
    try {
      await sl<UserLocalDataSource>().setUser(userParams: userParams);
      return Right(UserEntity(displayName: userParams.displayName, description: userParams.description));
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> disconnect() async {
    try {
      await sl<UserLocalDataSource>().deleteUser();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}

