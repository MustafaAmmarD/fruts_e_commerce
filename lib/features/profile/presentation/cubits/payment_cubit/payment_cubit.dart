import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';
import 'package:fruts_e_commerce/core/repos/payment_repo/payment_repo.dart';

abstract class PaymentState {}
class PaymentInitial extends PaymentState {}
class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {
  final List<PaymentCardEntity> cards;
  PaymentSuccess(this.cards);
}
class PaymentFailure extends PaymentState {
  final String errMessage;
  PaymentFailure(this.errMessage);
}

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());

  final PaymentRepo paymentRepo;

  Future<void> fetchCards({required String uId}) async {
    emit(PaymentLoading());
    final result = await paymentRepo.fetchCards(uId: uId);
    result.fold(
      (failure) => emit(PaymentFailure(failure.message)),
      (cards) => emit(PaymentSuccess(cards)),
    );
  }
}
