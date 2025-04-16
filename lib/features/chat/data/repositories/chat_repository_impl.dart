import 'package:dartz/dartz.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../../../../core/params/user_params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_local_data_source.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/chat_model.dart';
import 'dart:async';
import '../../domain/entities/message_entity.dart';

class ChatRepositoryImpl implements ChatRepository {
  final _messageController = StreamController<MessageEntity>.broadcast();

  ChatRepositoryImpl();

  @override
  Future<Either<Failure, ChatModel>> getChat({required ChatParams chatParams}) async {
    try {
      ChatModel remoteChat = await sl<ChatRemoteDataSource>().getChat(chatParams: chatParams);

      sl<ChatLocalDataSource>().cacheChat(); // chatToCache: remoteChat

      return Right(remoteChat);
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'This is a server exception'));
    }
  }

  @override
  Future<Either<Failure, NearbyService>> initializeP2PConnection ({required UserParams userParams}) async {
    try {
      
      NearbyService nearbyService = await sl<ChatRemoteDataSource>().init(userParams: userParams);

      return Right(nearbyService);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<MessageEntity>>> receiveMessages() async {
    return Right(_messageController.stream);
  }

  @override
  Future<void> sendMessage(MessageEntity message) async {
    // TODO: Implémenter l'envoi de message P2P
    // Pour l'instant, on simule juste la réception locale
    _messageController.add(message);
  }

  @override
  Future<void> closeConnection() async {
    await _messageController.close();
    // TODO: Nettoyer les ressources P2P
  }
}
