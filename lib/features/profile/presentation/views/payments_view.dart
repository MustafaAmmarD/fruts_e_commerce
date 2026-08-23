import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/core/repos/payment_repo/payment_repo.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/payment_cubit/payment_cubit.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/payments_view_body.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  static const routeName = 'payments_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(getIt.get<PaymentRepo>())..fetchCards(uId: getUser().uId),
      child: Scaffold(
        appBar: buildAppBar(context, title: 'المدفوعات', showBackButton: true),
        body: const SafeArea(
          child: PaymentsViewBody(),
        ),
      ),
    );
  }
}
