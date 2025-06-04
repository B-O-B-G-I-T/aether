import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class SaveMessage implements UseCase<void, MessageEntity> {
  SaveMessage();

  @override
  Future<Either<Failure, void>> call({
    required MessageEntity param,
  }) async {
    return await sl<ChatRepository>().saveMessage(message: param);
  }
}
