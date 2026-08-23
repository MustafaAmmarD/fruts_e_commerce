part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartItemAdded extends CartState {
  final List<CartItemEntity> cartItems;
  CartItemAdded({required this.cartItems});
}

class CartItemRemoved extends CartState {
  final List<CartItemEntity> cartItems;
  CartItemRemoved({required this.cartItems});
}

class CartQuantityUpdated extends CartState {
  final List<CartItemEntity> cartItems;
  CartQuantityUpdated({required this.cartItems});
}
