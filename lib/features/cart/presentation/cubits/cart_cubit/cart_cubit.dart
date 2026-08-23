import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/features/cart/domain/entities/cart_item_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItemEntity> _cartItems = [];

  List<CartItemEntity> get cartItems => _cartItems;

  void addProduct(ProductEntity product, {int count = 1}) {
    final existingItemIndex = _cartItems.indexWhere((item) => item.product.code == product.code);
    
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].count += count;
    } else {
      _cartItems.add(CartItemEntity(product: product, count: count));
    }
    
    emit(CartItemAdded(cartItems: List.from(_cartItems)));
  }

  void removeProduct(ProductEntity product) {
    _cartItems.removeWhere((item) => item.product.code == product.code);
    emit(CartItemRemoved(cartItems: List.from(_cartItems)));
  }

  void updateQuantity(ProductEntity product, int count) {
    final existingItemIndex = _cartItems.indexWhere((item) => item.product.code == product.code);
    if (existingItemIndex != -1) {
      if (count > 0) {
        _cartItems[existingItemIndex].count = count;
        emit(CartQuantityUpdated(cartItems: List.from(_cartItems)));
      } else {
        removeProduct(product);
      }
    }
  }

  num get totalPrice {
    return _cartItems.fold(0, (total, item) => total + item.totalPrice);
  }

  void clearCart() {
    _cartItems.clear();
    emit(CartItemRemoved(cartItems: List.from(_cartItems)));
  }
}
