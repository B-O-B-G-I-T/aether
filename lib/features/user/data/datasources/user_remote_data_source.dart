import '../../../../core/params/user_params.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel>   getUser({required UserParams userParams});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  UserRemoteDataSourceImpl();

  @override
  Future<UserModel> getUser({required UserParams userParams}) async {
    
    return UserModel( displayName: 'User 1', description: 'Description 1');
  }
}
