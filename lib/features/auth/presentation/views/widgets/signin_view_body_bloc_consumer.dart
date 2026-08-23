
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/helper_functions/build_error_bar.dart';
import 'package:fruts_e_commerce/core/widgets/custom_progress_hud.dart';
import 'package:fruts_e_commerce/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/main_view.dart';

class SigninViewBodyBlockConsumer extends StatelessWidget {
  const SigninViewBodyBlockConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
          if(state is SigninSuccess){
            Navigator.pushNamed(context, MainView.routeName);
          }
          if(state is SigninFailure){
            BuildErrorBar(context, state.message);
          }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading,
          child: const SigninViewBody(),
        );
      },
    );
  }
}
