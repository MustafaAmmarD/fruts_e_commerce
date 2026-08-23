import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/model/product_model.dart';
import 'package:fruts_e_commerce/features/cart/domain/entities/cart_item_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.orderId,
    required super.uId,
    required super.totalPrice,
    required super.orderDate,
    required super.status,
    required super.cartItems,
    required super.shippingAddress,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      uId: json['uId'],
      totalPrice: json['totalPrice'],
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
      shippingAddress: json['shippingAddress'],
      cartItems: (json['cartItems'] as List).map((e) {
        return CartItemEntity(
          product: ProductModel.fromjson(e['product']).toEntity(),
          count: e['count'],
        );
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'uId': uId,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
      'shippingAddress': shippingAddress,
      'cartItems': cartItems.map((e) {
        return {
          'product': ProductModel.fromEntity(e.product).tojson(),
          'count': e.count,
        };
      }).toList(),
    };
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      orderId: entity.orderId,
      uId: entity.uId,
      totalPrice: entity.totalPrice,
      orderDate: entity.orderDate,
      status: entity.status,
      cartItems: entity.cartItems,
      shippingAddress: entity.shippingAddress,
    );
  }
}
