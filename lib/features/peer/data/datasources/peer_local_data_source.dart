import '../models/peer_model.dart';

abstract class PeerLocalDataSource {
  Future<void> cachePeer();
  // {required PeerModel? peerToCache}
  Future<PeerModel> getLastPeer();
}

const cachedPeer = 'CACHED_TEMPLATE';

class PeerLocalDataSourceImpl implements PeerLocalDataSource {
  //final SharedPreferencesWithCache   sharedPreferences;

  PeerLocalDataSourceImpl();
  //{required this.sharedPreferences}

  @override
  Future<PeerModel> getLastPeer() {
    //final jsonString = sharedPreferences.getString(cachedPeer);

    // if (jsonString != null) {
    //   return Future.value(PeerModel.fromJson(json: json.decode(jsonString)));
    // } else {
    //   throw CacheException();
    // }
    return Future.value(PeerModel(peer: ""));
  }

  @override
  Future<void> cachePeer() async { // {required PeerModel? peerToCache}
    //   if (peerToCache != null) {
    //     sharedPreferences.setString(
    //       cachedPeer,
    //       json.encode(
    //         peerToCache.toJson(),
    //       ),
    //     );
    //   } else {
    //     throw CacheException();
    //   }
    
  }
}
