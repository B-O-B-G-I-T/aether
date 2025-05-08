import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failure.dart';
import '../../../../../core/constants/usecase/usecase.dart';
import '../../../../../core/params/chat_params.dart';
import '../../../../../service_locator.dart';
import '../../repositories/conversations_repository.dart';

class DeleteConversationUsecase implements UseCase<void, UpdateConversationParams> {
  DeleteConversationUsecase();

  @override
  Future<Either<Failure, void>> call({required UpdateConversationParams param}) async {
    return await sl<ConversationsRepository>().deleteConversation(param);
  }
}
