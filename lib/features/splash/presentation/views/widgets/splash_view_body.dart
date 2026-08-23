

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/services/firebase_auth_service.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/main_view.dart';
import 'package:fruts_e_commerce/features/on_boarding/presentation/views/on_boarding_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {

  @override
  void initState() {
    excuteNavigation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
       
       Row(
        mainAxisAlignment: MainAxisAlignment.end  ,
         children: [
           SvgPicture.asset(Assets.imagesPlant),
         ],
       ),
       SvgPicture.asset(Assets.imagesLogo),
       SvgPicture.asset(
        Assets.imagesSplashBottom,
        fit: BoxFit.fill,
        ),
   
    ],);
  }

  
void excuteNavigation() {

  bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeen);
  Future.delayed(
    const Duration(seconds: 3),
    () {
      // Navigate to the next screen
      if (isOnBoardingViewSeen) {
  var isLoggedIn =  FirebaseAuthService().isLoggedIn();

  if(isLoggedIn){
    Navigator.pushReplacementNamed(context, MainView.routeName);
  }else{
    Navigator.pushReplacementNamed(context, SigninView.routeName);
  } 
}else{
  Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
}
    },
  );
} 
}
