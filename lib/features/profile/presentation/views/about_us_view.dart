import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/about_us_view_body.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  static const routeName = 'about_us_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'من نحن', showBackButton: true),
      body: const SafeArea(
        child: AboutUsViewBody(),
      ),
    );
  }
}
