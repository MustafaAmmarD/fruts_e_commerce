import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';

class ProductFeatureItem extends StatelessWidget {
  const ProductFeatureItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F1F5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F3E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bold13.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.regular13.copyWith(
                  color: const Color(0xFF979899),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
