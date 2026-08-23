part of 'add_order_cubit.dart';

abstract class AddOrderState {}

class AddOrderInitial extends AddOrderState {}

class AddOrderLoading extends AddOrderState {}

class AddOrderSuccess extends AddOrderState {}

class AddOrderFailure extends AddOrderState {
  final String errMessage;
  AddOrderFailure(this.errMessage);
}
