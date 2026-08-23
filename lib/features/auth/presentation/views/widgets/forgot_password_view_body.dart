import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizntalBadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'لا تقلق، يحدث ذلك للجميع. الرجاء إدخال رقم هاتفك المحمول وسنرسل لك رمز التحقق.',
            style: AppTextStyles.regular16,
          ),
          const SizedBox(height: 32),
          const CustomTextFormField(
            hintText: 'رقم الهاتف المحمول',
            textInputType: TextInputType.phone,
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'إرسال الرمز',
            onPressed: () {
              Navigator.pushNamed(context, 'verify_code_view');
            },
          ),
        ],
      ),
    );
  }
}
