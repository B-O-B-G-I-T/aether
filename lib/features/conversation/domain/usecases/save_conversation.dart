import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/conversation_params.dart';
import '../../../../service_locator.dart';
import '../repositories/conversation_repository.dart';

class SaveConversation implements UseCase<void, SaveConversationParams> {
  SaveConversation();

  @override
  Future<Either<Failure, void>> call({
    required SaveConversationParams param,
  }) async {
    return await sl<ConversationRepository>().saveConversation(conversationParams: param);
  }
}
