import '../models/peer_config_model.dart';

abstract class PeerConfigLocalDataSource {
  Future<void> cachePeerConfig();
  // {required PeerConfigModel? templateToCache}
  Future<PeerConfigModel> getLastPeerConfig();
}

const cachedPeerConfig = 'CACHED_TEMPLATE';

class PeerConfigLocalDataSourceImpl implements PeerConfigLocalDataSource {
  //final SharedPreferencesWithCache   sharedPreferences;

  PeerConfigLocalDataSourceImpl();
  //{required this.sharedPreferences}

  @override
  Future<PeerConfigModel> getLastPeerConfig() {
    //final jsonString = sharedPreferences.getString(cachedPeerConfig);

    // if (jsonString != null) {
    //   return Future.value(PeerConfigModel.fromJson(json: json.decode(jsonString)));
    // } else {
    //   throw CacheException();
    // }
    return Future.value(PeerConfigModel(peerConfig: ""));
  }

  @override
  Future<void> cachePeerConfig() async { // {required PeerConfigModel? templateToCache}
    //   if (templateToCache != null) {
    //     sharedPreferences.setString(
    //       cachedPeerConfig,
    //       json.encode(
    //         templateToCache.toJson(),
    //       ),
    //     );
    //   } else {
    //     throw CacheException();
    //   }
    
  }
}
