import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:fruts_e_commerce/core/entites/address_entity.dart';
import 'package:fruts_e_commerce/core/errors/failures.dart';
import 'package:fruts_e_commerce/core/model/address_model.dart';
import 'package:fruts_e_commerce/core/repos/address_repo/address_repo.dart';
import 'package:fruts_e_commerce/core/services/database_service.dart';

class AddressRepoImpl implements AddressRepo {
  final DatabaseService databaseService;

  AddressRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, void>> addAddress({required AddressEntity address}) async {
    try {
      await databaseService.addData(
        path: 'addresses',
        data: AddressModel.fromEntity(address).toJson(),
        documentId: address.id,
      );
      return const Right(null);
    } catch (e) {
      log('Error in addAddress: $e');
      return Left(ServerFailure('حدث خطأ أثناء إضافة العنوان، يرجى المحاولة لاحقاً'));
    }
  }

  @override
  Future<Either<Failure, List<AddressEntity>>> getAddresses({required String uId}) async {
    try {
      var data = await databaseService.getData(
        path: 'addresses',
        query: {
          'whereField': 'uId',
          'whereIsEqualTo': uId,
        },
      );
      List<AddressEntity> addresses = (data as List)
          .map<AddressEntity>((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList();
      
      return Right(addresses);
    } catch (e) {
      log('Error in getAddresses: $e');
      return Left(ServerFailure('حدث خطأ أثناء جلب العناوين، يرجى المحاولة لاحقاً'));
    }
  }
}
