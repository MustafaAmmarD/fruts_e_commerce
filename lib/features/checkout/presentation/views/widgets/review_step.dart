import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/helper_functions/get_user.dart';
import 'package:fruts_e_commerce/features/cart/presentation/cubits/cart_cubit/cart_cubit.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/add_order_cubit/add_order_cubit.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/checkout_cubit/checkout_cubit.dart';

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cartCubit = context.watch<CartCubit>();
    final subtotal = cartCubit.totalPrice;
    final delivery = 30; // Fixed delivery fee for now
    final total = subtotal + delivery;
    final address = context.read<CheckoutCubit>().selectedAddress;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'ملخص الطلب :',
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F5F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow('المجموع الفرعي :', '$subtotal جنيه'),
                        const SizedBox(height: 12),
                        _buildSummaryRow('التوصيل :', '$delivery جنيه'),
                        const Divider(height: 24, color: Color(0xFFE2E2E9)),
                        _buildSummaryRow('الإجمالي :', '$total جنيه', isTotal: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'يرجي تأكيد طلبك :',
                    style: AppTextStyles.bold16,
                  ),
                  const SizedBox(height: 16),
                  _buildConfirmationCard(
                    title: 'طريقة الدفع',
                    subtitle: context.read<CheckoutCubit>().selectedPaymentCard != null 
                        ? '**** **** **** ${context.read<CheckoutCubit>().selectedPaymentCard!.cardNumber.length >= 4 ? context.read<CheckoutCubit>().selectedPaymentCard!.cardNumber.substring(context.read<CheckoutCubit>().selectedPaymentCard!.cardNumber.length - 4) : context.read<CheckoutCubit>().selectedPaymentCard!.cardNumber}'
                        : 'Cash on Delivery',
                    icon: Icons.credit_card,
                    onEdit: () => context.read<CheckoutCubit>().goToStep(2),
                  ),
                  const SizedBox(height: 16),
                  _buildConfirmationCard(
                    title: 'عنوان التوصيل',
                    subtitle: address != null ? address.toString() : 'لم يتم تحديد عنوان',
                    icon: Icons.location_on_outlined,
                    onEdit: () => context.read<CheckoutCubit>().goToStep(1),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<AddOrderCubit, AddOrderState>(
            listener: (context, state) {
              if (state is AddOrderSuccess) {
                context.read<CheckoutCubit>().nextStep();
              } else if (state is AddOrderFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errMessage)),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                text: 'تأكيد الطلب',
                isLoading: state is AddOrderLoading,
                onPressed: () {
                  final user = getUser();
                  if (user.uId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء تسجيل الدخول أولاً')),
                    );
                    return;
                  }

                  final order = OrderEntity(
                    orderId: DateTime.now().millisecondsSinceEpoch.toString(),
                    uId: user.uId,
                    totalPrice: total,
                    orderDate: DateTime.now(),
                    status: 'قيد المعالجة',
                    cartItems: cartCubit.cartItems,
                    shippingAddress: address != null ? address.toString() : 'لم يتم تحديد عنوان',
                  );

                  context.read<AddOrderCubit>().addOrder(order: order);
                },
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? AppTextStyles.bold16
              : AppTextStyles.regular16.copyWith(color: const Color(0xFF949D9E)),
        ),
        Text(
          value,
          style: isTotal ? AppTextStyles.bold16 : AppTextStyles.bold16,
        ),
      ],
    );
  }

  Widget _buildConfirmationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F1F5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F5F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.regular13.copyWith(color: const Color(0xFF949D9E))),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.bold13),
              ],
            ),
          ),
          InkWell(
            onTap: onEdit,
            child: Text(
              'تعديل',
              style: AppTextStyles.bold13.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
