import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartItem});

  final CartItemEntity cartItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Container(
          width: 73,
          height: 92,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F5F7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: cartItem.product.imageUrl != null
              ? Image.network(
                  cartItem.product.imageUrl!,
                  fit: BoxFit.contain,
                )
              : const Icon(Icons.image_not_supported, color: Colors.grey),
        ),
        const SizedBox(width: 17),
        // Product Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.product.name,
                style: AppTextStyles.bold13,
              ),
              const SizedBox(height: 6),
              Text(
                '${cartItem.count} كجم', // Assuming unit is kg based on design
                style: AppTextStyles.regular13.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${cartItem.totalPrice} جنيه',
                style: AppTextStyles.bold13.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
        // Actions
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                context.read<CartCubit>().removeProduct(cartItem.product);
              },
              child: const Icon(
                Icons.delete_outline,
                color: Color(0xFF949D9E),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: const Color(0xFFF1F1F5)),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<CartCubit>().updateQuantity(
                          cartItem.product, cartItem.count - 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                        color: Color(0xFF949D9E),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${cartItem.count}',
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      context.read<CartCubit>().updateQuantity(
                          cartItem.product, cartItem.count + 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
