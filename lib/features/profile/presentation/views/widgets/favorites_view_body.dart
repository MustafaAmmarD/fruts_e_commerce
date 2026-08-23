import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/products_grid_view.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/favorites_cubit/favorites_cubit.dart';

class FavoritesViewBody extends StatelessWidget {
  const FavoritesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, productsState) {
        if (productsState is ProductsSuccess) {
          return BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favoritesState) {
              final favoriteCodes = context.read<FavoritesCubit>().favoriteCodes;
              final favoriteProducts = productsState.products
                  .where((product) => favoriteCodes.contains(product.code))
                  .toList();

              if (favoriteProducts.isEmpty) {
                return const Center(
                  child: Text(
                    'لا توجد منتجات مفضلة بعد',
                    style: AppTextStyles.bold16,
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  ProductsGridView(products: favoriteProducts),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              );
            },
          );
        } else if (productsState is ProductsFailure) {
          return Center(child: Text(productsState.errMessage));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
