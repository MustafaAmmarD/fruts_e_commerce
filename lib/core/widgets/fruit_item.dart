import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/widgets/custom_network_image.dart';
import 'package:fruts_e_commerce/core/widgets/scale_on_tap.dart';
import 'package:fruts_e_commerce/features/product_details/presentation/views/product_details_view.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/favorites_cubit/favorites_cubit.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key, required this.productEntity});
  
  final ProductEntity productEntity;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsView.routeName,
          arguments: productEntity,
        );
      },
      child: Container(
        decoration: ShapeDecoration(
          color: const Color(0xFFF3F5F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          )
        ),
        child: Stack(
          children: [
          Positioned.fill(child: Column(
            children: [
              const SizedBox(height: 20,),
              productEntity.imageUrl != null ? Flexible(child: CustomNetworkImage(imageUrl: productEntity.imageUrl!)) : Container(color: Colors.grey,height: 100,width: 100,),
              const SizedBox(height: 24,),
              ListTile( 
                title: Text(productEntity.name,
                 textAlign: TextAlign.right,
                 style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600
                ),),
                subtitle: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ' ${productEntity.price} ر.س ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondaryColor
                        )
                      ),
                      TextSpan(
                        text: '/',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightSecondaryColor
                        )
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondaryColor
                        )
                      ),
                      TextSpan(
                        text: ' الوحدة',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightSecondaryColor
                        )
                      ),
                    ]
                  )
                ),
                trailing: ScaleOnTap(
                  onTap: () {
                    context.read<CartCubit>().addProduct(productEntity);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إضافة المنتج إلى السلة بنجاح'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.add, color: Colors.white,),
                  ),
                ),
              ),
              
            ],
          )),
          Positioned(
            top: 0,
            right: 0,
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFavorite = context.read<FavoritesCubit>().isFavorite(productEntity.code);
                return IconButton(
                  onPressed: () {
                    context.read<FavoritesCubit>().toggleFavorite(productEntity.code);
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? Colors.red : null,
                  ),
                );
              },
            ),
          ),
        ],
       ),
      ),    
    );
  }
}
