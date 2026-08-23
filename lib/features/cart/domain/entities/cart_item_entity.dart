import 'package:fruts_e_commerce/core/entites/product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  int count;

  CartItemEntity({required this.product, this.count = 1});
  
  num get totalPrice => product.price * count;
}
