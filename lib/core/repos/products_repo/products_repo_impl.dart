import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/product_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';
import 'package:fruts_e_commerce/core/model/product_model.dart';
import 'package:fruts_e_commerce/core/repos/products_repo/products_repo.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';
import 'package:fruts_e_commerce/core/utils/backend_endpoint.dart';

class ProductsRepoImpl extends ProductsRepo {

  final DatabaseService databaseService;
  ProductsRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async{
    try {
  var data = await databaseService.getData(
    path: BackendEndpoint.getProducts,
     query:{
      'limit': 10,
      'orderBy': 'sellingCount',
      'descending': true
     } 
    )as List<Map<String, dynamic>>;
  
  List<ProductEntity> products = data.map((productJson) => ProductModel.fromjson(productJson).toEntity()).toList();
    
  return Right(products);
} on Exception catch (e) {
  return Left(ServerFailure('Failed to fetch products: ${e.toString()}'));
}
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async{
    try {
  var data = await databaseService.getData(path: BackendEndpoint.getProducts )as List<Map<String, dynamic>>;
  
  List<ProductEntity> products = data.map((productJson) => ProductModel.fromjson(productJson).toEntity()).toList();
    
  return Right(products);
} on Exception catch (e) {
  return Left(ServerFailure('Failed to fetch products: ${e.toString()}'));
}
  }

  
}