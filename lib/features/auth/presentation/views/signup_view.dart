import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/services/get_it_service.dart';
import 'package:fruts_e_commerce/core/widgets/custom_app_bar.dart';
import 'package:fruts_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:fruts_e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/signup_view_block_consumer.dart';

class SignupView extends StatelessWidget {
   const SignupView({super.key});
   
  static const String routeName = 'signup';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt<AuthRepo>()),
      child: Scaffold(
        appBar: customAppBar(context, title: 'إنشاء حساب'),
        body: SignupViewBlockConsumer(),
      ),
    );
  }
}
