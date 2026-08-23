import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/signin_view.dart';
import 'package:fruts_e_commerce/features/on_boarding/presentation/views/widgets/on_boarding_page_view.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;

  var currentPage = 0;

  @override
  void initState() {
    pageController=PageController();
    pageController.addListener((){
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: OnBoardingPageView(
          pageController: pageController,
        )),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            activeColor: AppColors.primaryColor,
            color: currentPage == 1
            ?AppColors.primaryColor
             :AppColors.primaryColor.withOpacity(0.5)
          ),
          ),
          SizedBox(
            height: 29,
          ),
          Visibility(
            visible: currentPage == 1  ? true : false,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizntalBadding),
              child: CustomButton(onPressed:(){
                Navigator.of(context).pushReplacementNamed(SigninView.routeName);
              } , text: 'ابدأ الان'),
            ),
          ),

          SizedBox(
            height: 43,
          )
      ],
    );
  }
}