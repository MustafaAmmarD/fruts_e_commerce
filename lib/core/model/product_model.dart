import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/model/review_model.dart';


class ProductModel {

  final String name;
  final num price;
  final String code;
  final num sellingCount;
  final String description;
  final bool isFeatured;
  String? imageUrl;
  final int expirationMonths;
  final isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRating =0;
  final num ratingCount =0;
  final List<ReviewModel> reviews;

  ProductModel({required this.isOrganic,required this.sellingCount,required this.reviews ,required this.expirationMonths, required this.numberOfCalories, required this.unitAmount, required this.name, required this.price, required this.code, required this.description,required this.isFeatured,this.imageUrl});


factory ProductModel.fromjson(Map<String, dynamic> json){
    return ProductModel(
      isOrganic: json['isOrganic'] ?? false,
      sellingCount: json['sellingCount'] ?? 0,
      expirationMonths: json['expirationMonths'] ?? 0,
      numberOfCalories: json['numberOfCalories'] ?? 0,
      unitAmount: json['unitAmount'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      isFeatured: json['isFeatured'] ?? false,
      imageUrl: json['imageUrl'],
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json['reviews'].map((reviewJson) => ReviewModel.fromJson(reviewJson)))
          : [],
    );
  }


  ProductEntity toEntity() {
    return ProductEntity(
      isOrganic: isOrganic,
      reviews: reviews.map((e) => e.toEntity()).toList(),
      expirationMonths: expirationMonths,
      numberOfCalories: numberOfCalories,
      unitAmount: unitAmount,
      name: name,
      price: price,
      code: code,
      description: description,
      isFeatured: isFeatured,
      imageUrl: imageUrl,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      isOrganic: entity.isOrganic,
      sellingCount: 0,
      reviews: [], // simplified for cart
      expirationMonths: entity.expirationMonths,
      numberOfCalories: entity.numberOfCalories,
      unitAmount: entity.unitAmount,
      name: entity.name,
      price: entity.price,
      code: entity.code,
      description: entity.description,
      isFeatured: entity.isFeatured,
      imageUrl: entity.imageUrl,
    );
  }
  tojson() {
    return {
      'name': name,
      'price': price,
      'code': code,
      'description': description,
      'imageUrl': imageUrl,
      'isFeatured': isFeatured,
      'expirationMonths': expirationMonths,
      'isOrganic': isOrganic,
      'numberOfCalories': numberOfCalories,
      'unitAmount': unitAmount,
      'sellingCount': sellingCount,
      'reviews': reviews.map((e) => e.toJson()).toList(),
    };
  }
  
  
}