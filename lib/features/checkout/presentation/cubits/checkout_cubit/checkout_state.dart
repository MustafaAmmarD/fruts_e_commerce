part of 'checkout_cubit.dart';

abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutStepChanged extends CheckoutState {
  final int currentStep;
  CheckoutStepChanged({required this.currentStep});
}
