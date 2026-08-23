import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart'; 

abstract class  ProductsRepo {
  Future<Either<Failure , List<ProductEntity>>> getProducts();
  Future<Either<Failure , List<ProductEntity>>> getBestSellingProducts();
}