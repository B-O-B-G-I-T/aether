import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, ChatEntity>> getChat({required ChatParams chatParams});

  Future<Either<Failure, Stream<MessageEntity>>> receiveMessages();
  Future<void> sendMessage(MessageEntity   message);

  Future<void> closeConnection();
}
