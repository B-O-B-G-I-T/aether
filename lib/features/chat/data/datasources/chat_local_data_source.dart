import '../models/chat_model.dart';

abstract class ChatLocalDataSource {
  Future<void> cacheChat();
  // {required ChatModel? chatToCache}
  Future<ChatModel> getLastChat();
}

const cachedChat = 'CACHED_TEMPLATE';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  //final SharedPreferencesWithCache   sharedPreferences;

  ChatLocalDataSourceImpl();
  //{required this.sharedPreferences}

  @override
  Future<ChatModel> getLastChat() {
    //final jsonString = sharedPreferences.getString(cachedChat);

    // if (jsonString != null) {
    //   return Future.value(ChatModel.fromJson(json: json.decode(jsonString)));
    // } else {
    //   throw CacheException();
    // }
    return Future.value(ChatModel(chat: ""));
  }

  @override
  Future<void> cacheChat() async { // {required ChatModel? chatToCache}
    //   if (chatToCache != null) {
    //     sharedPreferences.setString(
    //       cachedChat,
    //       json.encode(
    //         chatToCache.toJson(),
    //       ),
    //     );
    //   } else {
    //     throw CacheException();
    //   }
    
  }
}
