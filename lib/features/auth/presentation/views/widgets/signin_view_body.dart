import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';
import 'package:fruts_e_commerce/core/widgets/password_field.dart';
import 'package:fruts_e_commerce/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/dont_have_account_widget.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/social_login_button.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {

   AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizntalBadding),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 24),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: 'البريد الالكتروني',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              passwordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'forgot_password_view');
                    },
                    child: Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        color: AppColors.lightPrimaryColor,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 33,
              ),
              CustomButton(
                text: 'تسجيل الدخول',
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    formKey.currentState!.save();
                    // Perform login action with email and password
                    context.read<SigninCubit>().signin(email, password);
                  }else{
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {
                    });
                  }
                },
              ),
              
              SizedBox(
                height: 33,
              ),
              
              DontHaveAccountWidget(),
              SizedBox(
                height: 33,
              ),
              OrDivider(),
              SizedBox(
                height: 16,
              ),
              SocialLoginButton(
                image: Assets.imagesGoogle,
                title: 'التسجيل بواسطة جوجل',
                onPressed: () {

                  context.read<SigninCubit>().signInWithGoogle();
                },
              ),
              SizedBox(
                height: 16,
              ),
               SocialLoginButton(
                image: Assets.imagesApple,
                title: 'التسجيل بواسطة أبل',
                onPressed: () {},
              ),
              SizedBox(
                height: 16,
              ),
               SocialLoginButton(
                image: Assets.imagesFacebook,
                title: 'التسجيل بواسطة فيسبوك',
                onPressed: () {

                  context.read<SigninCubit>().signInWithFacebook();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
