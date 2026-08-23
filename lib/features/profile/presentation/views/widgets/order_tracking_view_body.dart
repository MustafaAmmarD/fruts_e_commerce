import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';

class OrderTrackingViewBody extends StatelessWidget {
  const OrderTrackingViewBody({super.key, required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderSummary(),
          const SizedBox(height: 16),
          _buildAddressCard(),
          const SizedBox(height: 24),
          Text(
            'حالة الطلب',
            style: AppTextStyles.bold16,
          ),
          const SizedBox(height: 16),
          _buildTimeline(),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
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
            child: const Icon(Icons.location_on_outlined, color: AppColors.primaryColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عنوان التوصيل',
                  style: AppTextStyles.regular13.copyWith(color: const Color(0xFF949D9E)),
                ),
                const SizedBox(height: 4),
                Text(
                  order.shippingAddress,
                  style: AppTextStyles.bold13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F1F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('محتويات الطلب #${order.orderId.substring(order.orderId.length - 6)}', style: AppTextStyles.bold13),
          const SizedBox(height: 12),
          ...order.cartItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${item.product.name} (x${item.count})', style: AppTextStyles.regular13),
                Text('${item.totalPrice} جنيه', style: AppTextStyles.bold13),
              ],
            ),
          )),
          const Divider(color: Color(0xFFE2E2E9), thickness: 1, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('الإجمالي', style: AppTextStyles.bold16),
              Text('${order.totalPrice} جنيه', style: AppTextStyles.bold16.copyWith(color: AppColors.primaryColor)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    final status = order.status;
    int currentStepIndex = 1;
    
    if (status == 'قيد المعالجة') currentStepIndex = 1;
    else if (status == 'تم قبول الطلب') currentStepIndex = 2;
    else if (status == 'الطلب قيد التوصيل') currentStepIndex = 3;
    else if (status == 'تم الاستلام') currentStepIndex = 4;
    else currentStepIndex = 1; // Default fallback

    return Column(
      children: [
        _buildTimelineStep(
          title: 'تم وضع الطلب',
          subtitle: '${order.orderDate.day}/${order.orderDate.month}/${order.orderDate.year}',
          isCompleted: currentStepIndex >= 1,
          isActive: currentStepIndex == 1,
          isLast: false,
        ),
        _buildTimelineStep(
          title: 'قيد المعالجة / تم قبول الطلب',
          subtitle: currentStepIndex >= 2 ? 'الطلب قيد التحضير' : '',
          isCompleted: currentStepIndex >= 2,
          isActive: currentStepIndex == 2,
          isLast: false,
        ),
        _buildTimelineStep(
          title: 'الطلب قيد التوصيل',
          subtitle: currentStepIndex >= 3 ? 'يتوقع وصوله قريباً' : '',
          isCompleted: currentStepIndex >= 3,
          isActive: currentStepIndex == 3,
          isLast: false,
        ),
        _buildTimelineStep(
          title: 'تم الاستلام',
          subtitle: currentStepIndex == 4 ? 'تم التوصيل بنجاح' : 'قريبا',
          isCompleted: currentStepIndex == 4,
          isActive: currentStepIndex == 4,
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String subtitle,
    required bool isCompleted,
    bool isActive = false,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isActive ? AppColors.primaryColor : Colors.white,
                border: Border.all(
                  color: isCompleted || isActive ? AppColors.primaryColor : const Color(0xFFE2E2E9),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : isActive
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? AppColors.primaryColor : const Color(0xFFE2E2E9),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bold16.copyWith(
                  color: isCompleted || isActive ? Colors.black : const Color(0xFF949D9E),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.regular13.copyWith(
                  color: const Color(0xFF949D9E),
                ),
              ),
              if (!isLast) const SizedBox(height: 16), // Match line height
            ],
          ),
        ),
      ],
    );
  }
}
