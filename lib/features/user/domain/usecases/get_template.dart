import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../service_locator.dart';
import '../entities/template_entity.dart';
import '../repositories/template_repository.dart';

class GetTemplate implements UseCase<TemplateEntity, TemplateParams> {
  GetTemplate();

  @override
  Future<Either<Failure, TemplateEntity>> call({
    required TemplateParams param,
  }) async {
    return await sl<TemplateRepository>().getTemplate(templateParams: param);
  }
}
