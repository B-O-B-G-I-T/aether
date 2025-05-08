import 'package:aether/service_locator.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/params/chat_params.dart';
import '../../domain/entities/conversation_entity.dart';
import '../../domain/repositories/conversations_repository.dart';
import '../datasources/conversations_local_data_source.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsLocalDataSource _localDataSource;

  ConversationsRepositoryImpl() : _localDataSource = sl<ConversationsLocalDataSource>();

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final conversations = await _localDataSource.getConversations();
      return Right(conversations);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addConversation(UpdateConversationParams param) async {
    try {
      await _localDataSource.addConversation(param.conversation);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateConversation(UpdateConversationParams param) async {
    try {
      await _localDataSource.updateConversation(param.conversation);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteConversation(UpdateConversationParams param) async {
    try {
      await _localDataSource.deleteConversation(param.conversation);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
