import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_data_source.dart';
import '../datasources/chat_remote_data_source.dart';
import 'dart:async';
import '../../domain/entities/message_entity.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl();

  @override
  Future<Either<Failure, Stream<List<MessageEntity>>>> initChat({required PeerParams peerParams}) async {
    try {
      Stream<List<MessageModel>> remoteChat = await sl<ChatRemoteDataSource>().initChat(peerParams: peerParams);

      // Créer un StreamController pour combiner les messages locaux et distants
      final StreamController<List<MessageEntity>> controller = StreamController();

      remoteChat.listen((messages) async {
        // Sauvegarder les nouveaux messages localement
        for (final message in messages) {
          await sl<ChatLocalDataSource>().saveMessage(message: message);
        }
        controller.add(messages);
      });

      return Right(controller.stream);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage({required SendMessageParams params}) async {
    try {
      final MessageModel message = await sl<ChatRemoteDataSource>().sendMessage(params: params);

      await sl<ChatLocalDataSource>().saveMessage(message: message);

      return Right(message);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getConversationMessages({required GetConversationMessagesParams params}) async {
    try {
      final List<MessageModel> messages = await sl<ChatLocalDataSource>().getMessages();
      return Right(messages);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }


}
