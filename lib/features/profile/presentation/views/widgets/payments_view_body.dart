import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';
import 'package:fruts_e_commerce/core/utils/app_colors.dart';
import 'package:fruts_e_commerce/core/utils/app_text_styles.dart';
import 'package:fruts_e_commerce/features/profile/presentation/cubits/payment_cubit/payment_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaymentsViewBody extends StatelessWidget {
  const PaymentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state is PaymentSuccess) {
          return _buildContent(context, state.cards);
        } else if (state is PaymentFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return _buildContent(context, _getDummyCards(), isLoading: true);
        }
      },
    );
  }

  Widget _buildContent(BuildContext context, List<PaymentCardEntity> cards, {bool isLoading = false}) {
    return Skeletonizer(
      enabled: isLoading,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'البطاقات المحفوظة',
              style: AppTextStyles.bold16,
            ),
            const SizedBox(height: 16),
            if (cards.isEmpty && !isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'لا توجد بطاقات محفوظة بعد',
                    style: AppTextStyles.bold16,
                  ),
                ),
              )
            else
              ...cards.map((card) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildPaymentCard(card),
                  )),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                // Handle add new card UI navigation here if needed, or open bottom sheet
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF9F1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'إضافة بطاقة جديدة',
                    style: AppTextStyles.bold13.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(PaymentCardEntity card) {
    IconData icon = Icons.credit_card;
    if (card.brand.toLowerCase() == 'visa') icon = Icons.credit_card; // replace with visa icon if available
    
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
                Text(card.brand, style: AppTextStyles.bold13),
                const SizedBox(height: 4),
                Text('**** **** **** ${card.cardNumber.length >= 4 ? card.cardNumber.substring(card.cardNumber.length - 4) : card.cardNumber}', 
                  style: AppTextStyles.regular13.copyWith(color: const Color(0xFF949D9E))),
              ],
            ),
          ),
          if (card.isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFEBF9F1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'افتراضي',
                style: AppTextStyles.regular13.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
    );
  }

  List<PaymentCardEntity> _getDummyCards() {
    return [
      PaymentCardEntity(
        id: '1',
        uId: 'dummy',
        cardNumber: '1234',
        brand: 'Visa',
        expiryDate: '12/25',
        isDefault: true,
      ),
    ];
  }
}
