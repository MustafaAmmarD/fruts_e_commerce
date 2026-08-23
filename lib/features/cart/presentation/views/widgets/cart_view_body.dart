import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruts_e_commerce/features/cart/presentation/views/widgets/cart_item_widget.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartItems = context.read<CartCubit>().cartItems;
        final totalPrice = context.read<CartCubit>().totalPrice;

        if (cartItems.isEmpty) {
          return const Center(
            child: Text(
              'السلة فارغة',
              style: AppTextStyles.bold19,
            ),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  color: const Color(0xFFEBF9F1),
                  child: Center(
                    child: Text(
                      'لديك ${cartItems.length} منتجات في سلة التسوق',
                      style: AppTextStyles.regular13.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 100),
                    itemCount: cartItems.length,
                    separatorBuilder: (context, index) => const Divider(
                      height: 32,
                      color: Color(0xFFF1F1F5),
                    ),
                    itemBuilder: (context, index) {
                      return CartItemWidget(cartItem: cartItems[index]);
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: CustomButton(
                text: 'الدفع $totalPrice جنيه',
                onPressed: () {
                  Navigator.pushNamed(context, 'checkout_view');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
