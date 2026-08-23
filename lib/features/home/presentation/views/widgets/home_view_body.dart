
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fruts_e_commerce/constants.dart';
import 'package:fruts_e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruts_e_commerce/core/widgets/search_text_field.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/best_selling_header.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/featured_list.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {

  @override
  void initState() {
    context.read<ProductsCubit>().getBestSellingProducts();
    super.initState();
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
                  const CustomHomeAppBar(),
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
                  const FeaturedList(),
                  const SizedBox(height: 12,),
                  const BestSellingHeader(),
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

