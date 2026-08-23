import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/auth/presentation/views/widgets/verify_code_view_body.dart';

class VerifyCodeView extends StatelessWidget {
  const VerifyCodeView({super.key});

  static const routeName = 'verify_code_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'التحقق من الرمز', showBackButton: true),
      body: const SafeArea(
        child: VerifyCodeViewBody(),
      ),
    );
  }
}
