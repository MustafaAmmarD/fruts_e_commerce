import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/features/best_selling_fruits/presentation/views/best_selling_view.dart';

class ProductsViewHeader extends StatelessWidget {
  const ProductsViewHeader({super.key, required this.productsLength});
  final int productsLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' $productsLength نتائج',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700
          ),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'search_view');
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0x66CACECE)),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: SvgPicture.asset(Assets.imagesFilter2)
          ),
        ),
        ],
    );
  }
}