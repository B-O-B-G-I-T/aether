import '../../../../core/constants/peer_constant.dart';
import '../../../../service_locator.dart';
import '../../../../commun/peer_config/data/datasources/database_config.dart';
import '../models/peer_model.dart';

abstract class PeerLocalDataSource {
  Future<List<PeerModel>> getPeers();
  Future<List<PeerModel>> getPeerByDeviceId(String deviceId);
  Future<void> updatePeer(PeerModel peer);
  Future<void> deletePeer(String peerId);
}

class PeerLocalDataSourceImpl implements PeerLocalDataSource {
  final DatabaseConfig _database;

  PeerLocalDataSourceImpl() : _database = sl<DatabaseConfig>();

  @override
  Future<List<PeerModel>> getPeers() async {
    final db = await _database.database;
    final List<Map<String, dynamic>> maps = await db.query('peers');
    final peers = maps.map((e) => PeerModel.fromJson(json: e)).toList();
    return peers;

  }

  @override
  Future<List<PeerModel>> getPeerByDeviceId(String deviceId) async {
    final db = await _database.database;

    final List<Map<String, dynamic>> maps = await db.query('peers', where: '$kPeerId = ?', whereArgs: [deviceId]);

    if (maps.isEmpty) return [];

    return maps.map((e) => PeerModel.fromJson(json: e)).toList();
  }

  @override
  Future<void> updatePeer(PeerModel peer) async {
    final db = await _database.database;
    await db.update(
      'peers',
      {
        kPeerName: peer.device.deviceName,
        kPeerDescription: peer.device.deviceName,
        kPeerPathImageProfile: peer.pathImageProfile,
        kPeerMyLastStartEncodeImage: peer.myLastStartEncodeImage,
        kState: peer.device.state.index,
      },
      where: '$kPeerId = ?',
      whereArgs: [peer.device.deviceId],
    );
  }

  @override
  Future<void> deletePeer(String peerId) async {
    final db = await _database.database;
    await db.delete('peers', where: '$kPeerId = ?', whereArgs: [peerId]);
  }
}
