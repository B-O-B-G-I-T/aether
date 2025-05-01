import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../../../service_locator.dart';
import '../../domain/repositories/template_repository.dart';
import '../datasources/template_local_data_source.dart';
import '../datasources/template_remote_data_source.dart';
import '../models/template_model.dart';

class TemplateRepositoryImpl implements TemplateRepository {
  TemplateRepositoryImpl();

  @override
  Future<Either<Failure, TemplateModel>> getTemplate({required TemplateParams templateParams}) async {

      try {
        TemplateModel remoteTemplate = await sl<TemplateRemoteDataSource>().getTemplate(templateParams: templateParams);

        sl<TemplateLocalDataSource>().cacheTemplate(templateToCache: remoteTemplate);

        return Right(remoteTemplate);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    
    }
  }

