import 'package:spotify/domain/entities/auth/user.dart';

class UserModel {
  String? imageURL;
  String? fullName;
  String? email;
  UserModel({
    this.imageURL,
    this.fullName,
    this.email,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      imageURL: imageURL,
      email: email,
      fullName: fullName,
    );
  }
}