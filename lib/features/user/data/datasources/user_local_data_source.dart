import 'package:sqflite/sqflite.dart';
import '../../../../core/constants/peer_constant.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../../../commun/peer_config/data/datasources/database_config.dart';
import '../../../peer/data/models/peer_model.dart';

abstract class UserLocalDataSource {
  Future<void> cacheUser({required PeerModel? userToCache});
  Future<PeerModel?> getLastUser();
  Future<void> setUser({required SavePeersParams userParams});
  Future<void> deleteUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseConfig _database;

  UserLocalDataSourceImpl() : _database = sl<DatabaseConfig>();

  @override
  Future<PeerModel?> getLastUser() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('peers', limit: 1);

    if (maps.isEmpty) {
      return null;
    }

    return PeerModel.fromJson(json: maps.first);
  }

  @override
  Future<void> setUser({required SavePeersParams userParams}) async {
    final db = await _database.database;
    await db.insert('peers', {
      kPeerId: userParams.peer.device.deviceId,
      kPeerName: userParams.peer.device.deviceName,
      kPeerDescription: userParams.peer.device.deviceName,
      kPeerPathImageProfile: userParams.peer.pathImageProfile,
      kPeerMyLastStartEncodeImage: userParams.peer.myLastStartEncodeImage,
      kState: userParams.peer.device.state.index,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<void> deleteUser() async {
    final db = await _database.database;
    await db.delete('peers');
  }

  @override
  Future<void> cacheUser({required PeerModel? userToCache}) async {
    if (userToCache != null) {
      final db = await _database.database;
      await db.insert('peers', {
        kPeerId: userToCache.device.deviceId,
        kPeerName: userToCache.device.deviceName,
        kPeerDescription: userToCache.device.deviceName,
        kPeerPathImageProfile: userToCache.pathImageProfile,
        kPeerMyLastStartEncodeImage: userToCache.myLastStartEncodeImage,
        kState: userToCache.device.state.toString(),
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      throw CacheException();
    }
  }
}
