import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/core/widgets/search_text_field.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/products_view_header.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts(); 
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimationLimiter(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: kTopPadding,),
                  buildAppBar(context, title: 'المنتجات', showBackButton: false),
                  const SizedBox(height: 16,),
                  SearchTextField(
                    onTap: () {
                      Navigator.pushNamed(context, 'search_view');
                    },
                    onFilterTap: () {
                      Navigator.pushNamed(context, 'search_view');
                    },
                  ),
                  const SizedBox(height: 12,),
                  ProductsViewHeader(productsLength: context.read<ProductsCubit>().productsLength,),
                  const SizedBox(height: 8,),
                ],
              ),
            ),
            const ProductsGridViewBlocBuilder()
          ],
        ),
      ),
    );
  }
}