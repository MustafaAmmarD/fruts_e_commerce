import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';

class PaymentCardModel extends PaymentCardEntity {
  PaymentCardModel({
    required super.id,
    required super.uId,
    required super.cardNumber,
    required super.brand,
    required super.expiryDate,
    required super.isDefault,
  });

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) {
    return PaymentCardModel(
      id: json['id'],
      uId: json['uId'],
      cardNumber: json['cardNumber'],
      brand: json['brand'],
      expiryDate: json['expiryDate'],
      isDefault: json['isDefault'] ?? false,
    );
  }

  factory PaymentCardModel.fromEntity(PaymentCardEntity entity) {
    return PaymentCardModel(
      id: entity.id,
      uId: entity.uId,
      cardNumber: entity.cardNumber,
      brand: entity.brand,
      expiryDate: entity.expiryDate,
      isDefault: entity.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uId': uId,
      'cardNumber': cardNumber,
      'brand': brand,
      'expiryDate': expiryDate,
      'isDefault': isDefault,
    };
  }
}
