import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../core/params/peer_params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';
import 'dart:async';
import '../../domain/entities/message_entity.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl();

  @override
  Future<Either<Failure, Stream<List<MessageModel>>>> initChat({required PeerParams peerParams}) async {
    try {
      Stream<List<MessageModel>> remoteChat = await sl<ChatRemoteDataSource>().initChat(peerParams: peerParams);

      return Right(remoteChat);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage({required SendMessageParams params}) async {
    try {
      final MessageEntity message = await sl<ChatRemoteDataSource>().sendMessage(params: params);

      return Right(message);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
