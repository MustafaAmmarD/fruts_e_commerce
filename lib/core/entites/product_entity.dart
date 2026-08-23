import 'package:fruts_e_commerce/core/entites/review_entity.dart';



class ProductEntity {

  final String name;
  final num price;
  final String code;
  final String description;
  final bool isFeatured;
  String? imageUrl;
  final int expirationMonths;
  final isOrganic;
  final int numberOfCalories;
  final int unitAmount;
  final num avgRating =0;
  final num ratingCount =0;
  final List<ReviewEntity> reviews;


  ProductEntity( {this.isOrganic=false,required this.reviews,required this.expirationMonths, required this.numberOfCalories, required this.unitAmount,required this.name, required this.price, required this.code, required this.description,required this.isFeatured,this.imageUrl});
  

  
  
}