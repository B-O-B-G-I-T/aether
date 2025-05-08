import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../entities/conversation_entity.dart';

abstract class ConversationsRepository {
  Future<Either<Failure, List<ConversationEntity>>> getConversations();
  Future<Either<Failure, void>> addConversation(UpdateConversationParams param);
  Future<Either<Failure, void>> updateConversation(UpdateConversationParams param);
  Future<Either<Failure, void>> deleteConversation(UpdateConversationParams param);
}
