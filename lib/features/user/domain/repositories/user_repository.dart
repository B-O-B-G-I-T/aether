import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/user_params.dart';
import '../entities/user_entity.dart';


abstract class UserRepository {
  Future<Either<Failure, UserEntity?>> getUser();
  Future<Either<Failure, UserEntity>> setUser({required UserParams userParams});
  Future<Either<Failure, void>> disconnect();
}
