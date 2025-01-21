import 'package:spotify/domain/entities/auth/user_entity.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageurl;
  UserModel({
    this.fullName,
    this.email,
    this.imageurl,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      email: map['email'],
      imageurl: map['imageurl'] ?? "",
    );
  }
}

extension UserModel1X on UserModel {
  UserEntity toEntity() {
    return UserEntity(fullName: fullName!, email: email!, imageurl: imageurl);
  }
}
