import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/user_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/user_params.dart';
import '../../../../service_locator.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({required UserModel? userToCache});
  Future<UserModel?> getLastUser();
  Future<void> setUser({required UserParams userParams});
  Future<void> deleteUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {

  UserLocalDataSourceImpl();

  @override
  Future<UserModel?> getLastUser() {
    final jsonString = sl<SharedPreferences>().getString(cachedUser);

    if (jsonString != null) {
      return Future.value(UserModel.fromJson(json: json.decode(jsonString)));
    } else {
      return Future.value(null);
    }

  }

  @override
  Future<void> setUser({required UserParams userParams}) async {
    await sl<SharedPreferences>().setString(cachedUser, json.encode(userParams.toJson()));
  }

  @override
  Future<void> deleteUser() async {
    await sl<SharedPreferences>().remove(cachedUser);
  }

  @override
  Future<void> cacheUser({required UserModel? userToCache}) async  {
      if (userToCache != null) {
        sl<SharedPreferences>().setString(
          cachedUser,
          json.encode(
            userToCache.toJson(),
          ),
        );
      } else {
        throw CacheException();
      }
    
  }
}
