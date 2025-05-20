import 'package:dartz/dartz.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../../peer/domain/entities/peer_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl();

  @override
  Future<Either<Failure, PeerEntity?>> getUser() async {

      try {
        //UserModel remoteUser = await sl<UserRemoteDataSource>().getUser();

        final lastUser = await sl<UserLocalDataSource>().getLastUser();

      return Right(lastUser);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PeerEntity>> setUser({required SavePeersParams userParams}) async {
    try {
      await sl<UserLocalDataSource>().setUser(userParams: userParams);
      return Right(PeerEntity(device: Device(userParams.peer.device.deviceId, userParams.peer.device.deviceName, userParams.peer.device.state, deviceDescription: userParams.peer.device.deviceDescription), myLastStartEncodeImage: userParams.peer.myLastStartEncodeImage,pathImageProfile: userParams.peer.pathImageProfile, ));
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

