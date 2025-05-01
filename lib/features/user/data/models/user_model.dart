import '../../../../core/constants/user_constants.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({

    required super.displayName,
    required super.description,
  });

  factory UserModel.fromJson({required Map<String, dynamic> json}) {
    return UserModel(
      displayName: json[kDisplayName],
      description: json[kDescription],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kDisplayName: displayName,
      kDescription: description,
    };
  }
}
