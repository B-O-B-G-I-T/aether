import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/conversation_params.dart';
import '../../../../service_locator.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/repositories/conversation_repository.dart';
import '../datasources/conversation_local_data_source.dart';
import '../models/conversation_model.dart';

class ConversationRepositoryImpl implements ConversationRepository {
  ConversationRepositoryImpl();

  @override
  Future<Either<Failure, ConversationEntity>> getConversation({required GetConversationParams conversationParams}) async {
    try {
      ConversationModel remoteConversation = await sl<ConversationLocalDataSource>().getConversation(conversationParams: conversationParams);

      return Right(remoteConversation);
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'This is a server exception'));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations({required GetConversationsParams conversationParams}) async {
    try {
      List<ConversationModel> remoteConversations = await sl<ConversationLocalDataSource>().getConversations();
      return Right(remoteConversations);
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'This is a server exception'));
    }
  }

  @override
  Future<Either<Failure, void>> saveConversation({required SaveConversationParams conversationParams}) async {
    try {
      await sl<ConversationLocalDataSource>().saveConversation(conversationToCache: conversationParams.conversation as ConversationModel);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'This is a cache exception'));
    }
  }
}
