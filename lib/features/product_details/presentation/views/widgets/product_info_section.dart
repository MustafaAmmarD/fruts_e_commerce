import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/widgets/product_quantity_and_rating.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/widgets/product_features_row.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.product,
    required this.onQuantityChanged,
  });

  final ProductEntity product;
  final ValueChanged<int> onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                style: AppTextStyles.bold19,
              ),
              Text(
                '${product.price} جنيه / الكيلو',
                style: AppTextStyles.bold16.copyWith(
                  color: AppColors.lightPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProductQuantityAndRating(
            onQuantityChanged: onQuantityChanged,
          ),
          const SizedBox(height: 16),
          Text(
            product.description,
            style: AppTextStyles.regular13.copyWith(
              color: const Color(0xFF4E5556),
              height: 1.8,
            ),
          ),
          const SizedBox(height: 24),
          ProductFeaturesRow(product: product),
        ],
      ),
    );
  }
}
