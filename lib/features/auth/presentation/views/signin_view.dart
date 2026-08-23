import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/custom_app_bar.dart';
import 'package:fruts_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:fruts_e_commerce/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/signin_view_body_bloc_consumer.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(title: 'تسجيل الدخول', context),
        body: SigninViewBodyBlockConsumer(),
      ),
    );
  }
}
