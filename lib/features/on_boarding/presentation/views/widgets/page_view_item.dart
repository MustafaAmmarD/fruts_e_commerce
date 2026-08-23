import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signin_view.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, required this.image, required this.backgroundImage, required this.subtitle, required this.title, required this.isVisible});

  final String image,backgroundImage;
  final String subtitle;
  final Widget title;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return Column(children: [

      SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Stack(
          children: [
            Positioned.fill(child: SvgPicture.asset(backgroundImage,fit: BoxFit.fill,)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0, 
              child: SvgPicture.asset(image,)),

              Visibility(
                visible:isVisible ,
                child: GestureDetector(
                  onTap: () {
                    Prefs.setBool(kIsOnBoardingViewSeen, true);
                    Navigator.of(context).pushReplacementNamed(SigninView.routeName);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('تخط'),
                  ),
                ),
              )
          ],
        ),
      ),
      SizedBox(height: 64,),
      title,
      SizedBox(
        height: 24,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(subtitle,textAlign: TextAlign.center,),
      )

    ],);
  }
}