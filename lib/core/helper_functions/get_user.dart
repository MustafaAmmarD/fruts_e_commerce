
import 'dart:convert';

import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/features/auth/data/model/user_model.dart';
import 'package:fruts_e_commerce/features/auth/domain/entites/user_entity.dart';

UserEntity getUser(){
  var jsonString = Prefs.getString(kUserData);
  // If no stored user data, return an empty/default user to avoid JSON parse errors
  if (jsonString == null || jsonString.isEmpty) {
    return UserModel(uId: '', email: '', name: '');
  }

  try {
    var userEntity = UserModel.fromjson(jsonDecode(jsonString));
    return userEntity;
  } catch (e) {
    // If stored JSON is malformed, return a default empty user instead of crashing
    return UserModel(uId: '', email: '', name: '');
  }
}