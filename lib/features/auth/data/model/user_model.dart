import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruts_e_commerce/features/auth/domain/entites/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.uId, required super.email, required super.name});

  factory UserModel.fromFirebaseUser(User user){

    return UserModel(uId: user.uid, email: user.email??'', name: user.displayName??'');
  }

  factory UserModel.fromjson(Map<String,dynamic> json){
    return UserModel(
      uId: json['uId'],
      email: json['email'],
      name: json['name'],
    );
  }

 factory UserModel.fromEntity(UserEntity user){
  return UserModel(uId: user.uId, email: user.email, name: user.name);
 }
    toMap() {
    return {
      'uId': uId,
      'email': email,
      'name': name,
    };
  }
}