import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/order_entity.dart';
import 'package:fruts_e_commerce/core/repos/orders_repo/orders_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this.ordersRepo) : super(AddOrderInitial());

  final OrdersRepo ordersRepo;

  Future<void> addOrder({required OrderEntity order}) async {
    emit(AddOrderLoading());
    final result = await ordersRepo.addOrder(order: order);
    result.fold(
      (failure) => emit(AddOrderFailure(failure.message)),
      (success) => emit(AddOrderSuccess()),
    );
  }
}
