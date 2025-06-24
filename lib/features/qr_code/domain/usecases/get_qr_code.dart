import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/constants/usecase/usecase.dart';
import '../../../../core/params/qr_code_params.dart';
import '../../../../service_locator.dart';
import '../entities/qr_code_entity.dart';
import '../repositories/qr_code_repository.dart';

class GetQrCode implements UseCase<QrCodeEntity, QrCodeParams> {
  GetQrCode();

  @override
  Future<Either<Failure, QrCodeEntity>> call({
    required QrCodeParams param,
  }) async {
    return await sl<QrCodeRepository>().getQrCode(qrCodeParams: param);
  }
}
