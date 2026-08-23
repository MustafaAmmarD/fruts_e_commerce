import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/repos/orders_repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.ordersRepo) : super(OrdersInitial());

  final OrdersRepo ordersRepo;

  Future<void> fetchOrders({required String uId}) async {
    emit(OrdersLoading());
    final result = await ordersRepo.getOrders(uId: uId);
    result.fold(
      (failure) => emit(OrdersFailure(failure.message)),
      (orders) => emit(OrdersSuccess(orders)),
    );
  }
}
