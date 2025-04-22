import 'package:aether/features/chat/domain/entities/message_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../service_locator.dart';
import '../repositories/chat_repository.dart';

class ReceiveMessages implements UseCase<Stream<MessageEntity>, ChatParams> {
  ReceiveMessages();

  @override
  Future<Either<Failure, Stream<MessageEntity>>> call({
    required ChatParams param,
  }) async {
    return await sl<ChatRepository>().receiveMessages();
  }
}
