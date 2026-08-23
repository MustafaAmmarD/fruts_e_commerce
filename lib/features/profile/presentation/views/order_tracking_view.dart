import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/build_app_bar.dart';
import 'package:fruts_e_commerce/features/profile/presentation/views/widgets/order_tracking_view_body.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key, required this.order});

  final OrderEntity order;

  static const routeName = 'order_tracking_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, title: 'تفاصيل الطلب', showBackButton: true),
      body: SafeArea(
        child: OrderTrackingViewBody(order: order),
      ),
    );
  }
}
