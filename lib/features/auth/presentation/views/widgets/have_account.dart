import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';

class HaveAccount extends StatelessWidget {
  const HaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
              TextSpan(children: [
              
            
               TextSpan(
        text: 'تمتلك حساب بالفعل؟ ',
        style: TextStyle(
          color: Color(0xff949D9E),
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
              ),
            
               TextSpan(
        recognizer: TapGestureRecognizer()..onTap =(){
          Navigator.pop(context);
        },
        text: 'تسجيل دخول' ,
        style: TextStyle(
          color: AppColors.lightPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
        
              ),
            
             
            
              ])
              
            );
  }
}