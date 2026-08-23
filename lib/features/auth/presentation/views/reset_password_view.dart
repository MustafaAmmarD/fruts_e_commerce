import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  static const routeName = 'reset_password_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'كلمة مرور جديدة', showBackButton: true),
      body: const SafeArea(
        child: ResetPasswordViewBody(),
      ),
    );
  }
}
