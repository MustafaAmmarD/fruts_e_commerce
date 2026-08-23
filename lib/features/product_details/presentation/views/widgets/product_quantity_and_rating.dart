import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';

class ProductQuantityAndRating extends StatefulWidget {
  const ProductQuantityAndRating({super.key, required this.onQuantityChanged});

  final ValueChanged<int> onQuantityChanged;

  @override
  State<ProductQuantityAndRating> createState() =>
      _ProductQuantityAndRatingState();
}

class _ProductQuantityAndRatingState extends State<ProductQuantityAndRating> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: const Color(0xFFF1F1F5)),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                    widget.onQuantityChanged(quantity);
                  }
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
              const SizedBox(width: 16),
              Text(
                '$quantity',
                style: AppTextStyles.bold16,
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  setState(() {
                    quantity++;
                  });
                  widget.onQuantityChanged(quantity);
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
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Color(0xFFFFC529),
              size: 20,
            ),
            const SizedBox(width: 4),
            Text(
              '4.5',
              style: AppTextStyles.bold13,
            ),
            const SizedBox(width: 4),
            Text(
              '(30+)',
              style: AppTextStyles.regular13.copyWith(
                color: const Color(0xFF979899),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              'المراجعة',
              style: AppTextStyles.bold13.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
