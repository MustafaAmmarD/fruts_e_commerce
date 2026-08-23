import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';
import 'package:fruts_e_commerce/core/model/order_model.dart';
import 'package:fruts_e_commerce/core/repos/orders_repo/orders_repo.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';

class OrdersRepoImpl implements OrdersRepo {
  final DatabaseService databaseService;

  OrdersRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, void>> addOrder({required OrderEntity order}) async {
    try {
      await databaseService.addData(
        path: 'orders',
        data: OrderModel.fromEntity(order).toJson(),
        documentId: order.orderId,
      );
      return const Right(null);
    } catch (e) {
      log('Error in addOrder: $e');
      return Left(ServerFailure('حدث خطأ أثناء إضافة الطلب، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({required String uId}) async {
    try {
      var data = await databaseService.getData(
        path: 'orders',
        query: {
          'whereField': 'uId',
          'whereIsEqualTo': uId,
        },
      );
      List<OrderEntity> orders = (data as List)
          .map<OrderEntity>((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList();
      // Sort locally by orderDate descending to avoid Firestore composite index requirement
      orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
      
      return Right(orders);
    } catch (e) {
      log('Error in getOrders: $e');
      return Left(ServerFailure('حدث خطأ أثناء جلب الطلبات، يرجى المحاولة لاحقاً'));
    }
  }
}
