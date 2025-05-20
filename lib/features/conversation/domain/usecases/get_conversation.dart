import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/conversation_params.dart';
import '../../../../service_locator.dart';
import '../entities/conversation_entity.dart';
import '../repositories/conversation_repository.dart';

class GetConversation implements UseCase<ConversationEntity, GetConversationParams> {
  GetConversation();

  @override
  Future<Either<Failure, ConversationEntity>> call({
    required GetConversationParams param,
  }) async {
    return await sl<ConversationRepository>().getConversation(conversationParams: param );
  }
}
