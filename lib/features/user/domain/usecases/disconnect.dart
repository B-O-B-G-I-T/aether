import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/params.dart';
import '../../../../service_locator.dart';
import '../repositories/user_repository.dart';

class Disconnect implements UseCase<void, NoParams> {
  Disconnect();

  @override
  Future<Either<Failure, void>> call({
    required NoParams param,
  }) async {
    return await sl<UserRepository>().disconnect();
  }
}
