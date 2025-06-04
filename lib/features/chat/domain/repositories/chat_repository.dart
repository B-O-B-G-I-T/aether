import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../core/params/peer_params.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, Stream<List<MessageEntity>>>> initChat({required PeerParams peerParams});
  Future<Either<Failure, void>> saveMessage({required MessageEntity message});
  Future<Either<Failure, MessageEntity>> sendMessage({required SendMessageParams params});
  Future<Either<Failure, List<MessageEntity>>> getConversationMessages({required GetConversationMessagesParams params});

}
