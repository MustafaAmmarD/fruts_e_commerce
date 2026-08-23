import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({super.key, required this.onPressed, required this.image, required this.title});

  final VoidCallback onPressed;
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Color(0xffDCDEDE),
              width: 1
            )
          ),
          backgroundColor: Colors.white,
         // minimumSize: Size(double.infinity, 56 )
        ),
        onPressed: onPressed,
        child: ListTile(
          visualDensity: VisualDensity(
            vertical: VisualDensity.minimumDensity
          ),
          leading: SvgPicture.asset(image),
          title:Text( 
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
         ) ,
        ),
          
         ),
    );
  }
}