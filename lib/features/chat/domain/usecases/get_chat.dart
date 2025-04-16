import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../service_locator.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChat implements UseCase<ChatEntity, ChatParams> {
  GetChat();

  @override
  Future<Either<Failure, ChatEntity>> call({
    required ChatParams param,
  }) async {
    return await sl<ChatRepository>().getChat(chatParams: param);
  }
}
