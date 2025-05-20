import '../../../../core/params/conversation_params.dart';
import '../models/conversation_model.dart';

abstract class ConversationRemoteDataSource {
  Future<ConversationModel>   getConversation({required ConversationParams conversationParams});
}

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {

  ConversationRemoteDataSourceImpl();

  @override
  Future<ConversationModel> getConversation({required ConversationParams conversationParams}) async {
    
    return ConversationModel( lastMessage: 'Conversation 1', lastActivity: '2021-01-01', peerId: '1');
  }
}
