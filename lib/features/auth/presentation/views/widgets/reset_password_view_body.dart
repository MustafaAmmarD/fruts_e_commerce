import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/password_field.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizntalBadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'قم بإنشاء كلمة مرور جديدة لحسابك.',
            style: AppTextStyles.regular16,
          ),
          const SizedBox(height: 32),
          passwordField(
            onSaved: (value) {},
          ),
          const SizedBox(height: 16),
          // We can reuse passwordField for confirm password for now, though it should ideally say "Confirm Password"
          passwordField(
            onSaved: (value) {},
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'حفظ كلمة المرور',
            onPressed: () {
              // Successfully reset password, navigate back to sign in
              Navigator.pushNamedAndRemoveUntil(
                context,
                'login',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
