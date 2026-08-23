import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static const routeName = 'forgot_password_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'نسيان كلمة المرور', showBackButton: true),
      body: const SafeArea(
        child: ForgotPasswordViewBody(),
      ),
    );
  }
}
