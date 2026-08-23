import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signup_view.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/custom_check_box.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({super.key, required this.onChanged});

  final ValueChanged<bool>? onChanged; 

  @override
  State<TermsAndConditionsWidget> createState() => _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {

  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, 0),
      child: Row(
        children: [
          CustomCheckBox(  
            onChecked: (value){
              isTermsAccepted = value;
              widget.onChanged!(value);
              setState(() {
                
              });
            },
            isChecked: isTermsAccepted,
            ),
          SizedBox(width: 16,),
          Expanded(
            child: Text.rich(
                  TextSpan(children: [
                  
                
                   TextSpan(
            text: ' من خلال إنشاء حساب ، فإنك توافق على',
            style: TextStyle(
              color: Color(0xff949D9E),
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
                  ),
                
                   TextSpan(
            recognizer: TapGestureRecognizer()..onTap =(){
              Navigator.pushNamed(context, SignupView.routeName);
            },
            text: ' الشروط والأحكام الخاصة بنا' ,
            style: TextStyle(
              color: AppColors.lightPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
            
                  ),
                
                 
                
                  ])
                  
                ),
          )
        ],
      ),
    );
  }
}