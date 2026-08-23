import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/repos/orders_repo/orders_repo.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/add_order_cubit/add_order_cubit.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  static const routeName = 'checkout_view';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CheckoutCubit()),
        BlocProvider(create: (context) => AddOrderCubit(getIt.get<OrdersRepo>())),
      ],
      child: Scaffold(
        appBar: buildAppBar(
          context,
          title: 'الشحن', // This will change dynamically based on step later
          showBackButton: true,
        ),
        body: const CheckoutViewBody(),
      ),
    );
  }
}
