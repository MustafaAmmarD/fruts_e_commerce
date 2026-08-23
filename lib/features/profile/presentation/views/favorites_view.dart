import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruts_e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/favorites_view_body.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  static const routeName = 'favorites_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(getIt.get<ProductsRepo>())..getProducts(),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'المفضلة', showBackButton: true),
        body: const SafeArea(
          child: FavoritesViewBody(),
        ),
      ),
    );
  }
}
