
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signup_view.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(children: [
      
    
       TextSpan(
        text: 'ليس لديك حساب؟',
        style: TextStyle(
          color: Color(0xff949D9E),
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
      ),
       
      TextSpan(
        text: ' ',
        style: TextStyle(
          color: Color(0xFF616A6B),
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
        
      ),
    
       TextSpan(
        recognizer: TapGestureRecognizer()..onTap =(){
          Navigator.pushNamed(context, SignupView.routeName);
        },
        text: ' انشاء حساب' ,
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
        
      ),
    
     
    
      ])
      
    );
  }
}