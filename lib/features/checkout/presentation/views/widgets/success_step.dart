import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';

class SuccessStep extends StatelessWidget {
  const SuccessStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'تم بنجاح!',
            style: AppTextStyles.bold19,
          ),
          const SizedBox(height: 8),
          Text(
            'رقم الطلب #1245789663',
            style: AppTextStyles.regular16.copyWith(
              color: const Color(0xFF949D9E),
            ),
          ),
          const Spacer(),
          CustomButton(
            text: 'تتبع الطلب',
            onPressed: () {
              // Navigate to order tracking
            },
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              context.read<CartCubit>().clearCart();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text(
              'الرئيسية',
              style: AppTextStyles.bold16.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
