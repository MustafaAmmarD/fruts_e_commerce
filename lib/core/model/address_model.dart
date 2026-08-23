import 'package:fruts_e_commerce/core/entites/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.uId,
    required super.name,
    required super.email,
    required super.street,
    required super.city,
    required super.floor,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      uId: json['uId'],
      name: json['name'],
      email: json['email'],
      street: json['street'],
      city: json['city'],
      floor: json['floor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uId': uId,
      'name': name,
      'email': email,
      'street': street,
      'city': city,
      'floor': floor,
    };
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      uId: entity.uId,
      name: entity.name,
      email: entity.email,
      street: entity.street,
      city: entity.city,
      floor: entity.floor,
    );
  }
}
