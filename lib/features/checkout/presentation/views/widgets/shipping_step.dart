import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/widgets/custom_button.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/shipping_item_widget.dart';

class ShippingStep extends StatefulWidget {
  const ShippingStep({super.key});

  @override
  State<ShippingStep> createState() => _ShippingStepState();
}

class _ShippingStepState extends State<ShippingStep> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  ShippingItemWidget(
                    title: 'الدفع عند الاستلام',
                    subtitle: 'الدفع نقدا عند استلام الطلب',
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ShippingItemWidget(
                    title: 'اشتري الان وادفع لاحقا',
                    subtitle: 'عبر البطاقة الائتمانية',
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          CustomButton(
            text: 'التالي',
            onPressed: () {
              context.read<CheckoutCubit>().nextStep();
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
