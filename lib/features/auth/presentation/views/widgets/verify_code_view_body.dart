import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/widgets/custom_text_field.dart';

class VerifyCodeViewBody extends StatelessWidget {
  const VerifyCodeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizntalBadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'أدخل الرمز المكون من 4 أرقام المرسل إلى رقم هاتفك.',
            style: AppTextStyles.regular16,
          ),
          const SizedBox(height: 32),
          // In a real app we'd use a package like pin_code_fields, but we'll use a simple text field for now
          const CustomTextFormField(
            hintText: 'رمز التحقق (مثال: 1234)',
            textInputType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'إعادة إرسال الرمز',
                style: AppTextStyles.bold16.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'تأكيد الرمز',
            onPressed: () {
              Navigator.pushNamed(context, 'reset_password_view');
            },
          ),
        ],
      ),
    );
  }
}
