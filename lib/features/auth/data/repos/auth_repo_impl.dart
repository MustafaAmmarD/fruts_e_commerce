
import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/errors/exceptions.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';
import 'package:fruts_e_commerce/core/services/firebase_auth_service.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/core/utils/backend_endpoint.dart';
import 'package:fruts_e_commerce/features/auth/data/model/user_model.dart';
import 'package:fruts_e_commerce/features/auth/domain/entites/user_entity.dart';
import 'package:fruts_e_commerce/features/auth/domain/repos/auth_repo.dart';


class AuthRepoImpl implements AuthRepo {

  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl({required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(String email, String password,String name) async {
  User? user;
   try {
   user = await firebaseAuthService.createUserWithEmailAndPassword(email: email, password: password,); 
  var user_entity = UserEntity(uId: user.uid, email: email, name: name);
  await addUserData(user: user_entity);
  await saveUserData(user: user_entity);
  return right(user_entity);
} on CustomExceptions catch (e) {
  await deleteUser(user);
  return left(ServerFailure(e.message));
} catch (e) {
  await deleteUser(user);
  log( ' Exception in createUserWithEmailAndPassword AuthRepoImpl : ${e.toString()}');
  return left(ServerFailure("  حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا"));
  }
  }

  Future<void> deleteUser(User? user) async {
    if(user != null){
      await firebaseAuthService.deleteUser();
    }
  }


  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
      var userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in signInWithEmailAndPassword AuthRepoImpl: ${e.toString()}');
      return left(ServerFailure("حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async { 
    User? user;
    try {
       user = await firebaseAuthService.signInWithGoogle();
      var user_entity = UserModel.fromFirebaseUser(user);
      var isUserExists = await databaseService.checkIfDataExists(path: BackendEndpoint.isUserExists, documentId: user_entity.uId);
      if (isUserExists) {
         user_entity = await getUserData(uid: user.uid) as UserModel;
      }else{
         await addUserData(user: user_entity);
      }
      await saveUserData(user: user_entity);
      return right(user_entity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in signInWithGoogle AuthRepoImpl: ${e.toString()}');
      return left(ServerFailure("حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا"));
    }
  }


  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
       user = await firebaseAuthService.signInWithFacebook();
      var user_entity = UserModel.fromFirebaseUser(user);
      await addUserData(user: user_entity);
      return right(user_entity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in signInWithFacebook AuthRepoImpl: ${e.toString()}');
      return left(ServerFailure("حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا"));
    }
  }
  
  @override
  Future addUserData({required UserEntity user}) async {
    
    await databaseService.addData(path: BackendEndpoint.addUserData, data: UserModel.fromEntity(user).toMap(), documentId: user.uId);
  }
  
  @override
  Future<UserEntity> getUserData({required String uid}) async {
   var userData = await databaseService.getData(path: BackendEndpoint.getUserData, documentId: uid);
   return UserModel.fromjson(userData);
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserData({required UserEntity user}) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.addUserData,
        data: UserModel.fromEntity(user).toMap(),
        documentId: user.uId,
      );
      await saveUserData(user: user);
      return Right(user);
    } catch (e) {
      log('Exception in updateUserData AuthRepoImpl: ${e.toString()}');
      return Left(ServerFailure("حدث خطأ أثناء التحديث، يرجى المحاولة لاحقاً"));
    }
  }
  
  @override
  Future saveUserData({required UserEntity user}) async {

  var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
   
   await Prefs.setString(kUserData, jsonData);
  }


        
       
      
}