import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';

abstract class PaymentRepo {
  Future<Either<Failure, void>> addCard(PaymentCardEntity card);
  Future<Either<Failure, List<PaymentCardEntity>>> fetchCards({required String uId});
}
