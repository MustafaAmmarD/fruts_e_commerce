import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/features/cart/presentation/views/widgets/cart_view_body.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'السلة',
        showBackButton: false,
      ),
      body: const CartViewBody(),
    );
  }
}
