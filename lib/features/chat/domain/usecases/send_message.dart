import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../service_locator.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class SendMessage implements UseCase<MessageEntity, SendMessageParams> {
  SendMessage();

  @override
  Future<Either<Failure, MessageEntity>> call({required SendMessageParams param}) async {
    return await sl<ChatRepository>().sendMessage(params: param);
  }
}
