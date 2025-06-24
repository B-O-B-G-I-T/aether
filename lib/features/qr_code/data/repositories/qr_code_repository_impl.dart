import 'package:dartz/dartz.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/qr_code_params.dart';
import '../../domain/entities/qr_code_entity.dart';
import '../../domain/repositories/qr_code_repository.dart';

class QrCodeRepositoryImpl implements QrCodeRepository {
  QrCodeRepositoryImpl();

  @override
  Future<Either<Failure, QrCodeEntity>> getQrCode({required QrCodeParams qrCodeParams}) async {

      try {

        return Right(QrCodeEntity(template: ''));
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    
    }
  }

