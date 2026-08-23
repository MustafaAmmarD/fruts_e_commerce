import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';
import 'package:fruts_e_commerce/core/repos/payment_repo/payment_repo.dart';

abstract class AddCardState {}
class AddCardInitial extends AddCardState {}
class AddCardLoading extends AddCardState {}
class AddCardSuccess extends AddCardState {}
class AddCardFailure extends AddCardState {
  final String errMessage;
  AddCardFailure(this.errMessage);
}

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit(this.paymentRepo) : super(AddCardInitial());

  final PaymentRepo paymentRepo;

  Future<void> addCard({required PaymentCardEntity card}) async {
    emit(AddCardLoading());
    final result = await paymentRepo.addCard(card);
    result.fold(
      (failure) => emit(AddCardFailure(failure.message)),
      (_) => emit(AddCardSuccess()),
    );
  }
}
