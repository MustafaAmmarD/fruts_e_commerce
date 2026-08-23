import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/cubits/checkout_cubit/checkout_cubit.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/checkout_steps.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/shipping_step.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/address_step.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/payment_step.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/review_step.dart';
import 'package:fruts_e_commerce/features/checkout/presentation/views/widgets/success_step.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final currentStep = context.read<CheckoutCubit>().currentStep;

        if (currentStep == 4) {
          return const SuccessStep();
        }

        return Column(
          children: [
            const SizedBox(height: 16),
            CheckoutSteps(currentStep: currentStep),
            const SizedBox(height: 32),
            Expanded(
              child: _getStepWidget(currentStep),
            ),
          ],
        );
      },
    );
  }

  Widget _getStepWidget(int step) {
    switch (step) {
      case 0:
        return const ShippingStep();
      case 1:
        return const AddressStep();
      case 2:
        return const PaymentStep();
      case 3:
        return const ReviewStep();
      default:
        return const SizedBox();
    }
  }
}
