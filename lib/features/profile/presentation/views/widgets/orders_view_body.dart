import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/orders_cubit/orders_cubit.dart';

class OrdersViewBody extends StatelessWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrdersFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is OrdersSuccess) {
          if (state.orders.isEmpty) {
            return const Center(child: Text('لا توجد طلبات سابقة', style: AppTextStyles.bold16));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              return _buildOrderItem(context, state.orders[index]);
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildOrderItem(BuildContext context, OrderEntity order) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'order_tracking_view', arguments: order);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFF1F1F5)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              spreadRadius: 0,
              blurRadius: 9,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'رقم الطلب #${order.orderId.substring(order.orderId.length - 6)}',
                  style: AppTextStyles.bold13,
                ),
                Text(
                  '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
                  style: AppTextStyles.regular13.copyWith(
                    color: const Color(0xFF949D9E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.local_shipping,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  order.status,
                  style: AppTextStyles.bold13.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Color(0xFFF1F1F5), height: 1),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المبلغ الإجمالي:',
                  style: AppTextStyles.regular13.copyWith(
                    color: const Color(0xFF949D9E),
                  ),
                ),
                Text(
                  '${order.totalPrice} جنيه',
                  style: AppTextStyles.bold13,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
