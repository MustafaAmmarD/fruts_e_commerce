import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/address_entity.dart';

import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  int currentStep = 0;
  AddressEntity? selectedAddress;
  PaymentCardEntity? selectedPaymentCard;

  void nextStep() {
    if (currentStep < 4) {
      currentStep++;
      emit(CheckoutStepChanged(currentStep: currentStep));
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      emit(CheckoutStepChanged(currentStep: currentStep));
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 4) {
      currentStep = step;
      emit(CheckoutStepChanged(currentStep: currentStep));
    }
  }
}
