import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/payment_card_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';
import 'package:fruts_e_commerce/core/model/payment_card_model.dart';
import 'package:fruts_e_commerce/core/repos/payment_repo/payment_repo.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';

class PaymentRepoImpl implements PaymentRepo {
  final DatabaseService databaseService;

  PaymentRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, void>> addCard(PaymentCardEntity card) async {
    try {
      final cardModel = PaymentCardModel.fromEntity(card);
      await databaseService.addData(
        path: 'users/${card.uId}/cards',
        data: cardModel.toJson(),
        documentId: card.id,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('حدث خطأ أثناء إضافة البطاقة. الرجاء المحاولة مرة أخرى.'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentCardEntity>>> fetchCards({required String uId}) async {
    try {
      final data = await databaseService.getData(
        path: 'users/$uId/cards',
      );
      if (data is Iterable) {
        final cards = data.map((e) => PaymentCardModel.fromJson(e)).toList();
        return Right(cards);
      }
      return const Right([]);
    } catch (e) {
      return Left(ServerFailure('حدث خطأ أثناء جلب البطاقات المحفوظة.'));
    }
  }
}
