import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/conversation_params.dart';
import '../entities/conversation_entity.dart';


abstract class ConversationRepository {
  Future<Either<Failure, ConversationEntity>> getConversation({
    required GetConversationParams conversationParams,
  });
  Future<Either<Failure, void>> saveConversation({
    required SaveConversationParams conversationParams,
  });
  Future<Either<Failure, List<ConversationEntity>>> getConversations({
    required GetConversationsParams conversationParams,
  });
}
