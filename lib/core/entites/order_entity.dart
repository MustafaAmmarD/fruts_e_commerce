import 'package:fruts_e_commerce/features/cart/domain/entities/cart_item_entity.dart';

class OrderEntity {
  final String orderId;
  final String uId;
  final num totalPrice;
  final DateTime orderDate;
  final String status;
  final List<CartItemEntity> cartItems;
  final String shippingAddress;

  OrderEntity({
    required this.orderId,
    required this.uId,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
    required this.cartItems,
    required this.shippingAddress,
  });
}
