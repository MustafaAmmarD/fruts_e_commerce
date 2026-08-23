import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';

abstract class OrdersRepo {
  Future<Either<Failure, void>> addOrder({required OrderEntity order});
  Future<Either<Failure, List<OrderEntity>>> getOrders({required String uId});
}
