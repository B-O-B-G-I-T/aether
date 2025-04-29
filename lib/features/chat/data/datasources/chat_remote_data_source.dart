import '../../../../core/params/chat_params.dart';
import '../models/chat_model.dart';

abstract class ChatRemoteDataSource {
  Future<ChatModel>   getChat({required ChatParams chatParams});

}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {

  ChatRemoteDataSourceImpl();
  @override
  Future<ChatModel> getChat({required ChatParams chatParams}) async {
    
    return ChatModel( chat: 'Chat 1');
  }
}
