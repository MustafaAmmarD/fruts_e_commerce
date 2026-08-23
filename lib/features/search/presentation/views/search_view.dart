import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:fruts_e_commerce/features/search/presentation/cubits/search_cubit/search_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const routeName = 'search_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(getIt.get<ProductsRepo>()),
      child: const Scaffold(
        body: SafeArea(
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
