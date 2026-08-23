import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            color: Color(0xFFF3F5F7),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Center(
            child: product.imageUrl != null
                ? Hero(
                    tag: product.code,
                    child: Image.network(
                      product.imageUrl!,
                      height: MediaQuery.of(context).size.height * 0.25,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: 80,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  )
                : const Icon(
                    Icons.image_not_supported_outlined,
                    size: 80,
                    color: Color(0xFFCCCCCC),
                  ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
