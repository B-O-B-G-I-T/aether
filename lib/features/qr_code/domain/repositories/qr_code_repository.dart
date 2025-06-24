import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/qr_code_params.dart';
import '../entities/qr_code_entity.dart';


abstract class QrCodeRepository {
  Future<Either<Failure, QrCodeEntity>> getQrCode({
    required QrCodeParams qrCodeParams,
  });
}
