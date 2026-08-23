import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/widgets/product_feature_item.dart';

class ProductFeaturesRow extends StatelessWidget {
  const ProductFeaturesRow({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProductFeatureItem(
          title: '100%',
          subtitle: 'اورجانيك',
          icon: Icons.eco_outlined,
        ),
        ProductFeatureItem(
          title: '${product.expirationMonths} شهر',
          subtitle: 'الصلاحيه',
          icon: Icons.calendar_month_outlined,
        ),
        ProductFeatureItem(
          title: '${product.numberOfCalories} كالوري',
          subtitle: '100 جرام',
          icon: Icons.local_fire_department_outlined,
        ),
      ],
    );
  }
}
