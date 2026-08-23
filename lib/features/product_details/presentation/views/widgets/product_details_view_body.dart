import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/widgets/product_image_section.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/widgets/product_info_section.dart';

class ProductDetailsViewBody extends StatefulWidget {
  const ProductDetailsViewBody({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageSection(product: widget.product),
                ProductInfoSection(
                  product: widget.product,
                  onQuantityChanged: (value) {
                    count = value;
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: CustomButton(
            text: 'أضف الي السلة',
            onPressed: () {
              context.read<CartCubit>().addProduct(widget.product, count: count);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('تم إضافة المنتج إلى السلة بنجاح'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
