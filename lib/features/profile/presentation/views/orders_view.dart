import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/repos/orders_repo/orders_repo.dart';
import 'package:fruts_e_commerce/core/services/firebase_auth_service.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/orders_cubit/orders_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/orders_view_body.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  static const routeName = 'orders_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final uId = getIt.get<FirebaseAuthService>().getUser()?.uid ?? '';
        return OrdersCubit(getIt.get<OrdersRepo>())..fetchOrders(uId: uId);
      },
      child: Scaffold(
        appBar: buildAppBar(context, title: 'طلباتي', showBackButton: true),
        body: const SafeArea(
          child: OrdersViewBody(),
        ),
      ),
    );
  }
}
