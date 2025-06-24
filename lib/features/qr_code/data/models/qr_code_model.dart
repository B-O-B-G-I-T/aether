import '../../../../core/constants/qr_code_constant.dart';
import '../../domain/entities/qr_code_entity.dart';

class QrCodeModel extends QrCodeEntity {
  const QrCodeModel({
    required super.template,
  });

  factory QrCodeModel.fromJson({required Map<String, dynamic> json}) {
    return QrCodeModel(
      template: json[kQrCode],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kQrCode: template,
    };
  }
}
