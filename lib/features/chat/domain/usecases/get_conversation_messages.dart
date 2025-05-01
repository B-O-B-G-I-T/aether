import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../service_locator.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class GetConversationMessages implements UseCase<List<MessageEntity>, GetConversationMessagesParams> {
  GetConversationMessages();

  @override
  Future<Either<Failure, List<MessageEntity>>> call({required GetConversationMessagesParams param}) async {
    return await sl<ChatRepository>().getConversationMessages(params: param);
  }
}
