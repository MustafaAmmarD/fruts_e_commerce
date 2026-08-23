import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/helper_functions/build_error_bar.dart';
import 'package:fruts_e_commerce/core/widgets/custom_progress_hud.dart';
import 'package:fruts_e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupViewBlockConsumer extends StatelessWidget {
  const SignupViewBlockConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
          
          if(state is SignupSuccess){
            Navigator.pop(context);
          }
          if(state is SignupFailure){
            BuildErrorBar(context, state.message);
          }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignupLoading,
          child: const SignupViewBody(),
        );
      },
    );
  }

  
}
