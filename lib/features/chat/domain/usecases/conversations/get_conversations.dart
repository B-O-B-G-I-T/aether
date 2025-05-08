import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../core/constants/usecase/usecase.dart';
import '../../../../../core/params/chat_params.dart';
import '../../../../../service_locator.dart';
import '../../entities/conversation_entity.dart';
import '../../repositories/conversations_repository.dart';

class GetConversations implements UseCase<List<ConversationEntity>, GetConversationsParams> {
  GetConversations();

  @override
  Future<Either<Failure, List<ConversationEntity>>> call({required GetConversationsParams param}) async {
    return await sl<ConversationsRepository>().getConversations();
  }
}
