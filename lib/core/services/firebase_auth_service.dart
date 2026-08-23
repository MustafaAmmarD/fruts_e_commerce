import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fruts_e_commerce/core/errors/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';



class FirebaseAuthService {



   Future deleteUser () async {
    await FirebaseAuth.instance.currentUser!.delete();
   }


  Future<User> createUserWithEmailAndPassword({required String email, required String password}) async {
    
    try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email ,
    password: password,
  );
  return credential.user!;
} on FirebaseAuthException catch (e) {
  log(' FirebaseAuthException in createUserWithEmailAndPassword FirebaseAuthService : ${e.toString()}');
  if (e.code == 'weak-password') {
    throw CustomExceptions(message: ' كلمة المرور ضعيفة جداً');
  } else if (e.code == 'email-already-in-use') {
    throw CustomExceptions(message: ' هذا البريد الإلكتروني مستخدم مسبقاً');
  }else if(e.code == 'network-request-failed'){
    throw CustomExceptions(message: " تحقق من اتصالك بالإنترنت");
  }else{
    throw CustomExceptions(message:" حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا");
  }
} catch (e) {
  log(' FirebaseAuthException in createUserWithEmailAndPassword FirebaseAuthService : ${e.toString()}');
  throw CustomExceptions(message: " حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا");
}
  }

 Future<User> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('FirebaseAuthException in signInWithEmailAndPassword FirebaseAuthService: ${e.toString()}');
      if (e.code == 'user-not-found') {
        throw CustomExceptions(message: 'هذا البريد الإلكتروني غير مسجل');
      } else if (e.code == 'wrong-password') {
        throw CustomExceptions(message: 'كلمة المرور غير صحيحة');
      } else if (e.code == 'network-request-failed') {
        throw CustomExceptions(message: "تحقق من اتصالك بالإنترنت");
      } else {
        throw CustomExceptions(message: "حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا");
      }
    } catch (e) {
      log('FirebaseAuthException in signInWithEmailAndPassword FirebaseAuthService: ${e.toString()}');
      throw CustomExceptions(message: "حدث خطأ ما، يرجى المحاولة مرة أخرى لاحقًا");
    }
  }

  Future<User> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
}



Future<User> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();


  

  // Create a credential from the access token
 final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

  // Once signed in, return the UserCredential
  return (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user!;
}


bool isLoggedIn() {
  final user = FirebaseAuth.instance.currentUser;
  return user != null;
} 

User? getUser() {
  return FirebaseAuth.instance.currentUser;
}
}