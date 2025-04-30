import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

class InitChat implements UseCase<Stream<List<MessageEntity>>, PeerParams> {
  InitChat();

  @override
  Future<Either<Failure, Stream<List<MessageEntity>>>> call({
    required PeerParams param,
  }) async {
    return await sl<ChatRepository>().initChat(peerParams: param);
  }
}
