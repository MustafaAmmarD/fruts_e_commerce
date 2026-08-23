import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/helper_functions/build_error_bar.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';
import 'package:fruts_e_commerce/core/widgets/password_field.dart';
import 'package:fruts_e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/have_account.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/terms_and_conditions_widget.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); 
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, userName, password;
  bool isTermsAccepted = false; 
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizntalBadding),
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              SizedBox(height: 24,),
              CustomTextFormField(
                onSaved: (value) {
                  userName = value!;
                },
                hintText: "الاسم كامل", textInputType: TextInputType.name),
              SizedBox(height: 16,),
              CustomTextFormField(
                onSaved: (value) {
                  email = value!;
                },
                hintText: "البريد الإلكتروني", textInputType: TextInputType.emailAddress),
              SizedBox(height: 16,),
              passwordField(
                onSaved: (value) {
                  password = value!;
                },
              ),
              SizedBox(height: 16,),
              TermsAndConditionsWidget(
                onChanged: (value) {
                  isTermsAccepted = value;
                },
              ),
              SizedBox(height: 30,),
              CustomButton(onPressed: (){
                if(formKey.currentState!.validate()){
                  formKey.currentState!.save();
                  if (isTermsAccepted) {
                    if (email != null && password != null && userName != null) {
                      context.read<SignupCubit>().createUserWithEmailAndPassword(email!, password!, userName!);
                    } else {
                      BuildErrorBar(context, "يرجى تعبئة جميع الحقول بشكل صحيح");
                    }
                  }else{
                    BuildErrorBar(context, "يجب الموافقة على الشروط والأحكام");
                  }
                }else{
                  setState(() {
                    autovalidateMode = AutovalidateMode.always;
                  });
                }
              }, text: "إنشاء حساب"
              ),
              SizedBox(height: 26,),
              HaveAccount()
            ],
          ),
        ),
      ),
    );
  }
}
